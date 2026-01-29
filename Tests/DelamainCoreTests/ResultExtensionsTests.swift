import Testing
@testable import DelamainCore

@Suite("Result Extensions")
struct ResultExtensionsTests {
    
    // MARK: - isSuccess / isFailure
    
    @Test("isSuccess returns true for success")
    func isSuccessTrue() {
        let result: Result<Int, TestError> = .success(42)
        #expect(result.isSuccess)
    }
    
    @Test("isSuccess returns false for failure")
    func isSuccessFalse() {
        let result: Result<Int, TestError> = .failure(.testError)
        #expect(!result.isSuccess)
    }
    
    @Test("isFailure returns true for failure")
    func isFailureTrue() {
        let result: Result<Int, TestError> = .failure(.testError)
        #expect(result.isFailure)
    }
    
    @Test("isFailure returns false for success")
    func isFailureFalse() {
        let result: Result<Int, TestError> = .success(42)
        #expect(!result.isFailure)
    }
    
    // MARK: - value / error
    
    @Test("value returns success value")
    func valueReturnsSuccess() {
        let result: Result<Int, TestError> = .success(42)
        #expect(result.value == 42)
    }
    
    @Test("value returns nil for failure")
    func valueReturnsNil() {
        let result: Result<Int, TestError> = .failure(.testError)
        #expect(result.value == nil)
    }
    
    @Test("error returns failure error")
    func errorReturnsFailure() {
        let result: Result<Int, TestError> = .failure(.testError)
        #expect(result.error == .testError)
    }
    
    @Test("error returns nil for success")
    func errorReturnsNil() {
        let result: Result<Int, TestError> = .success(42)
        #expect(result.error == nil)
    }
    
    // MARK: - onSuccess / onFailure
    
    @Test("onSuccess executes for success")
    func onSuccessExecutes() {
        var received: Int?
        let result: Result<Int, TestError> = .success(42)
        result.onSuccess { received = $0 }
        #expect(received == 42)
    }
    
    @Test("onSuccess does not execute for failure")
    func onSuccessSkipsFailure() {
        var executed = false
        let result: Result<Int, TestError> = .failure(.testError)
        result.onSuccess { _ in executed = true }
        #expect(!executed)
    }
    
    @Test("onFailure executes for failure")
    func onFailureExecutes() {
        var received: TestError?
        let result: Result<Int, TestError> = .failure(.testError)
        result.onFailure { received = $0 }
        #expect(received == .testError)
    }
    
    @Test("onFailure does not execute for success")
    func onFailureSkipsSuccess() {
        var executed = false
        let result: Result<Int, TestError> = .success(42)
        result.onFailure { _ in executed = true }
        #expect(!executed)
    }
    
    // MARK: - mapError
    
    @Test("mapError transforms error type")
    func mapErrorTransforms() {
        let result: Result<Int, TestError> = .failure(.testError)
        let mapped: Result<Int, OtherError> = result.mapError { _ in .otherError }
        #expect(mapped.error == .otherError)
    }
    
    @Test("mapError preserves success")
    func mapErrorPreservesSuccess() {
        let result: Result<Int, TestError> = .success(42)
        let mapped: Result<Int, OtherError> = result.mapError { _ in .otherError }
        #expect(mapped.value == 42)
    }
    
    // MARK: - recover
    
    @Test("recover returns success unchanged")
    func recoverKeepsSuccess() {
        let result: Result<Int, TestError> = .success(42)
        let recovered = result.recover { _ in 0 }
        #expect(recovered == 42)
    }
    
    @Test("recover transforms failure to value")
    func recoverTransformsFailure() {
        let result: Result<Int, TestError> = .failure(.testError)
        let recovered = result.recover { _ in 0 }
        #expect(recovered == 0)
    }
}

// MARK: - Test Helpers

private enum TestError: Error, Equatable {
    case testError
}

private enum OtherError: Error, Equatable {
    case otherError
}
