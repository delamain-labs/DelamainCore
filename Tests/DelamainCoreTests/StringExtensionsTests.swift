import Testing
@testable import DelamainCore

@Suite("String Extensions")
struct StringExtensionsTests {
    
    // MARK: - isBlank / isNotBlank
    
    @Test("isBlank returns true for empty string")
    func isBlankEmpty() {
        #expect("".isBlank)
    }
    
    @Test("isBlank returns true for whitespace only")
    func isBlankWhitespace() {
        #expect("   ".isBlank)
        #expect("\t\n".isBlank)
        #expect(" \t \n ".isBlank)
    }
    
    @Test("isBlank returns false for non-blank string")
    func isBlankFalse() {
        #expect(!"hello".isBlank)
        #expect(!" hello ".isBlank)
    }
    
    @Test("isNotBlank returns true for non-blank string")
    func isNotBlankTrue() {
        #expect("hello".isNotBlank)
    }
    
    @Test("isNotBlank returns false for blank string")
    func isNotBlankFalse() {
        #expect(!"".isNotBlank)
        #expect(!"   ".isNotBlank)
    }
    
    // MARK: - trimmed
    
    @Test("trimmed removes leading and trailing whitespace")
    func trimmedBasic() {
        #expect("  hello  ".trimmed == "hello")
    }
    
    @Test("trimmed removes newlines and tabs")
    func trimmedNewlines() {
        #expect("\n\thello\t\n".trimmed == "hello")
    }
    
    @Test("trimmed returns same string if no whitespace")
    func trimmedNoChange() {
        #expect("hello".trimmed == "hello")
    }
    
    @Test("trimmed returns empty for whitespace only")
    func trimmedWhitespaceOnly() {
        #expect("   ".trimmed == "")
    }
    
    // MARK: - nilIfEmpty
    
    @Test("nilIfEmpty returns nil for empty string")
    func nilIfEmptyEmpty() {
        #expect("".nilIfEmpty == nil)
    }
    
    @Test("nilIfEmpty returns value for non-empty string")
    func nilIfEmptyNonEmpty() {
        #expect("hello".nilIfEmpty == "hello")
    }
    
    @Test("nilIfEmpty returns whitespace string (not blank-aware)")
    func nilIfEmptyWhitespace() {
        #expect("   ".nilIfEmpty == "   ")
    }
    
    // MARK: - nilIfBlank
    
    @Test("nilIfBlank returns nil for empty string")
    func nilIfBlankEmpty() {
        #expect("".nilIfBlank == nil)
    }
    
    @Test("nilIfBlank returns nil for whitespace only")
    func nilIfBlankWhitespace() {
        #expect("   ".nilIfBlank == nil)
        #expect("\t\n".nilIfBlank == nil)
    }
    
    @Test("nilIfBlank returns value for non-blank string")
    func nilIfBlankNonBlank() {
        #expect("hello".nilIfBlank == "hello")
    }
    
    // MARK: - truncated
    
    @Test("truncated returns same string if within limit")
    func truncatedWithinLimit() {
        #expect("hello".truncated(to: 10) == "hello")
    }
    
    @Test("truncated adds ellipsis when exceeding limit")
    func truncatedExceedsLimit() {
        #expect("hello world".truncated(to: 8) == "hello...")
    }
    
    @Test("truncated with custom trailing")
    func truncatedCustomTrailing() {
        #expect("hello world".truncated(to: 8, trailing: "…") == "hello w…")
    }
    
    @Test("truncated handles exact length")
    func truncatedExactLength() {
        #expect("hello".truncated(to: 5) == "hello")
    }
    
    @Test("truncated handles length shorter than trailing")
    func truncatedVeryShort() {
        #expect("hello".truncated(to: 2) == "he")
    }
}
