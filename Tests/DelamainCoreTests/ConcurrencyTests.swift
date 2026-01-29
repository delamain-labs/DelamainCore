import Testing
@testable import DelamainCore

@Suite("Concurrency Utilities")
struct ConcurrencyTests {
    
    // MARK: - withTimeout
    
    @Test("withTimeout completes within time limit")
    func withTimeoutCompletes() async throws {
        let result = try await withTimeout(seconds: 1.0) {
            return "completed"
        }
        #expect(result == "completed")
    }
    
    @Test("withTimeout throws when exceeding time limit")
    func withTimeoutThrows() async {
        await #expect(throws: TimeoutError.self) {
            try await withTimeout(seconds: 0.1) {
                try await Task.sleep(for: .seconds(1))
                return "should not reach"
            }
        }
    }
    
    // MARK: - retry
    
    @Test("retry succeeds on first attempt")
    func retrySucceedsFirst() async throws {
        var attempts = 0
        let result = try await retry(maxAttempts: 3) {
            attempts += 1
            return "success"
        }
        #expect(result == "success")
        #expect(attempts == 1)
    }
    
    @Test("retry succeeds after failures")
    func retrySucceedsAfterFailures() async throws {
        var attempts = 0
        let result = try await retry(maxAttempts: 3, delay: .milliseconds(10)) {
            attempts += 1
            if attempts < 3 {
                throw TestError.temporary
            }
            return "success"
        }
        #expect(result == "success")
        #expect(attempts == 3)
    }
    
    @Test("retry throws after max attempts")
    func retryThrowsAfterMax() async {
        var attempts = 0
        await #expect(throws: TestError.self) {
            try await retry(maxAttempts: 3, delay: .milliseconds(10)) {
                attempts += 1
                throw TestError.permanent
            } as String
        }
        #expect(attempts == 3)
    }
}

// MARK: - Test Helpers

private enum TestError: Error {
    case temporary
    case permanent
}
