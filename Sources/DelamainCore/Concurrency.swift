// MARK: - Concurrency Utilities

/// An error thrown when an operation times out.
public struct TimeoutError: Error, Sendable {
    public init() {}
}

/// Executes an async operation with a timeout.
///
/// ```swift
/// let result = try await withTimeout(seconds: 5.0) {
///     try await fetchData()
/// }
/// ```
///
/// - Parameters:
///   - seconds: The maximum time to wait in seconds.
///   - operation: The async operation to execute.
/// - Returns: The result of the operation.
/// - Throws: `TimeoutError` if the operation exceeds the timeout, or any error thrown by the operation.
public func withTimeout<T: Sendable>(
    seconds: Double,
    operation: @escaping @Sendable () async throws -> T
) async throws -> T {
    try await withThrowingTaskGroup(of: T.self) { group in
        group.addTask {
            try await operation()
        }
        
        group.addTask {
            try await Task.sleep(for: .seconds(seconds))
            throw TimeoutError()
        }
        
        let result = try await group.next()!
        group.cancelAll()
        return result
    }
}

/// Retries an async operation with exponential backoff.
///
/// ```swift
/// let data = try await retry(maxAttempts: 3, delay: .seconds(1)) {
///     try await fetchData()
/// }
/// ```
///
/// - Parameters:
///   - maxAttempts: The maximum number of attempts.
///   - delay: The initial delay between retries. Doubles with each attempt.
///   - operation: The async operation to retry.
/// - Returns: The result of the operation.
/// - Throws: The last error if all attempts fail.
public func retry<T>(
    maxAttempts: Int,
    delay: Duration = .seconds(1),
    operation: @escaping () async throws -> T
) async throws -> T {
    var lastError: Error?
    var currentDelay = delay
    
    for attempt in 1...maxAttempts {
        do {
            return try await operation()
        } catch {
            lastError = error
            if attempt < maxAttempts {
                try? await Task.sleep(for: currentDelay)
                currentDelay = Duration.seconds(currentDelay.components.seconds * 2)
            }
        }
    }
    
    throw lastError!
}
