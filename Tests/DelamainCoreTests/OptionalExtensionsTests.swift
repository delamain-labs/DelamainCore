import Testing
@testable import DelamainCore

@Suite("Optional Extensions")
struct OptionalExtensionsTests {
    
    // MARK: - orThrow
    
    @Test("orThrow returns value when present")
    func orThrowReturnsValue() throws {
        let optional: String? = "hello"
        let result = try optional.orThrow(TestError.missingValue)
        #expect(result == "hello")
    }
    
    @Test("orThrow throws error when nil")
    func orThrowThrowsWhenNil() {
        let optional: String? = nil
        #expect(throws: TestError.missingValue) {
            try optional.orThrow(TestError.missingValue)
        }
    }
    
    // MARK: - isNil / isNotNil
    
    @Test("isNil returns true for nil")
    func isNilTrue() {
        let optional: String? = nil
        #expect(optional.isNil)
    }
    
    @Test("isNil returns false for value")
    func isNilFalse() {
        let optional: String? = "hello"
        #expect(!optional.isNil)
    }
    
    @Test("isNotNil returns true for value")
    func isNotNilTrue() {
        let optional: String? = "hello"
        #expect(optional.isNotNil)
    }
    
    @Test("isNotNil returns false for nil")
    func isNotNilFalse() {
        let optional: String? = nil
        #expect(!optional.isNotNil)
    }
    
    // MARK: - apply
    
    @Test("apply executes closure when value present")
    func applyExecutes() {
        var executed = false
        let optional: String? = "hello"
        optional.apply { _ in executed = true }
        #expect(executed)
    }
    
    @Test("apply does not execute closure when nil")
    func applySkipsNil() {
        var executed = false
        let optional: String? = nil
        optional.apply { _ in executed = true }
        #expect(!executed)
    }
    
    // MARK: - or
    
    @Test("or returns value when present")
    func orReturnsValue() {
        let optional: String? = "hello"
        #expect(optional.or("default") == "hello")
    }
    
    @Test("or returns default when nil")
    func orReturnsDefault() {
        let optional: String? = nil
        #expect(optional.or("default") == "default")
    }
    
    // MARK: - orLazy
    
    @Test("orLazy returns value without calling closure")
    func orLazyReturnsValue() {
        var closureCalled = false
        let optional: String? = "hello"
        let result = optional.or {
            closureCalled = true
            return "default"
        }
        #expect(result == "hello")
        #expect(!closureCalled)
    }
    
    @Test("orLazy calls closure when nil")
    func orLazyCallsClosure() {
        var closureCalled = false
        let optional: String? = nil
        let result = optional.or {
            closureCalled = true
            return "default"
        }
        #expect(result == "default")
        #expect(closureCalled)
    }
}

// MARK: - Test Helpers

private enum TestError: Error, Equatable {
    case missingValue
}
