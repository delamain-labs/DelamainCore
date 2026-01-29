import Foundation

// MARK: - String Extensions

public extension String {
    
    /// Returns `true` if the string is empty or contains only whitespace.
    ///
    /// ```swift
    /// "".isBlank        // true
    /// "   ".isBlank     // true
    /// "hello".isBlank   // false
    /// ```
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Returns `true` if the string contains non-whitespace characters.
    ///
    /// ```swift
    /// "hello".isNotBlank  // true
    /// "   ".isNotBlank    // false
    /// ```
    var isNotBlank: Bool {
        !isBlank
    }
    
    /// Returns a copy of the string with leading and trailing whitespace removed.
    ///
    /// ```swift
    /// "  hello  ".trimmed  // "hello"
    /// "\n\thello\t\n".trimmed  // "hello"
    /// ```
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Returns `nil` if the string is empty, otherwise returns the string.
    ///
    /// Useful for converting empty strings to nil for optional handling.
    ///
    /// ```swift
    /// "".nilIfEmpty      // nil
    /// "hello".nilIfEmpty // "hello"
    /// "   ".nilIfEmpty   // "   " (whitespace preserved)
    /// ```
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
    
    /// Returns `nil` if the string is blank (empty or whitespace only).
    ///
    /// ```swift
    /// "".nilIfBlank      // nil
    /// "   ".nilIfBlank   // nil
    /// "hello".nilIfBlank // "hello"
    /// ```
    var nilIfBlank: String? {
        isBlank ? nil : self
    }
    
    /// Returns the string truncated to the specified length with a trailing indicator.
    ///
    /// ```swift
    /// "hello world".truncated(to: 8)           // "hello..."
    /// "hello world".truncated(to: 8, trailing: "…")  // "hello w…"
    /// "hello".truncated(to: 10)                // "hello"
    /// ```
    ///
    /// - Parameters:
    ///   - length: The maximum length of the returned string (including trailing).
    ///   - trailing: The string to append when truncation occurs. Defaults to "...".
    /// - Returns: The truncated string, or the original if within the length limit.
    func truncated(to length: Int, trailing: String = "...") -> String {
        guard count > length else { return self }
        
        let truncationLength = length - trailing.count
        guard truncationLength > 0 else {
            return String(prefix(length))
        }
        
        return String(prefix(truncationLength)) + trailing
    }
}
