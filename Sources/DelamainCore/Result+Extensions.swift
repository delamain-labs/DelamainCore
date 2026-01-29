// MARK: - Result Extensions

public extension Result {
    
    /// Returns `true` if the result is a success.
    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }
    
    /// Returns `true` if the result is a failure.
    var isFailure: Bool {
        if case .failure = self { return true }
        return false
    }
    
    /// Returns the success value, or `nil` if the result is a failure.
    ///
    /// ```swift
    /// let result: Result<Int, Error> = .success(42)
    /// result.value // Optional(42)
    /// ```
    var value: Success? {
        if case .success(let value) = self { return value }
        return nil
    }
    
    /// Returns the error, or `nil` if the result is a success.
    ///
    /// ```swift
    /// let result: Result<Int, MyError> = .failure(.notFound)
    /// result.error // Optional(MyError.notFound)
    /// ```
    var error: Failure? {
        if case .failure(let error) = self { return error }
        return nil
    }
    
    /// Executes the closure if the result is a success.
    ///
    /// ```swift
    /// fetchUser().onSuccess { user in
    ///     print("Hello, \(user.name)")
    /// }
    /// ```
    ///
    /// - Parameter closure: The closure to execute with the success value.
    /// - Returns: The result unchanged, for chaining.
    @discardableResult
    func onSuccess(_ closure: (Success) -> Void) -> Self {
        if case .success(let value) = self {
            closure(value)
        }
        return self
    }
    
    /// Executes the closure if the result is a failure.
    ///
    /// ```swift
    /// fetchUser().onFailure { error in
    ///     print("Failed: \(error)")
    /// }
    /// ```
    ///
    /// - Parameter closure: The closure to execute with the error.
    /// - Returns: The result unchanged, for chaining.
    @discardableResult
    func onFailure(_ closure: (Failure) -> Void) -> Self {
        if case .failure(let error) = self {
            closure(error)
        }
        return self
    }
    
    /// Transforms the error to a different error type.
    ///
    /// ```swift
    /// fetchData()
    ///     .mapError { networkError in AppError.network(networkError) }
    /// ```
    ///
    /// - Parameter transform: A closure that transforms the error.
    /// - Returns: A result with the transformed error type.
    func mapError<NewFailure: Error>(
        _ transform: (Failure) -> NewFailure
    ) -> Result<Success, NewFailure> {
        switch self {
        case .success(let value):
            return .success(value)
        case .failure(let error):
            return .failure(transform(error))
        }
    }
    
    /// Returns the success value or transforms the error into a value.
    ///
    /// ```swift
    /// let count = fetchItems()
    ///     .map(\.count)
    ///     .recover { _ in 0 }
    /// ```
    ///
    /// - Parameter transform: A closure that transforms the error into a success value.
    /// - Returns: The success value or the recovered value.
    func recover(_ transform: (Failure) -> Success) -> Success {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            return transform(error)
        }
    }
}
