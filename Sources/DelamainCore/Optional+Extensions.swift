// MARK: - Optional Extensions

public extension Optional {
    
    /// Returns the wrapped value or throws the provided error.
    ///
    /// ```swift
    /// let name: String? = fetchName()
    /// let unwrapped = try name.orThrow(ValidationError.missingName)
    /// ```
    ///
    /// - Parameter error: The error to throw if the optional is nil.
    /// - Returns: The wrapped value.
    /// - Throws: The provided error if the optional is nil.
    func orThrow(_ error: @autoclosure () -> some Error) throws -> Wrapped {
        guard let value = self else {
            throw error()
        }
        return value
    }
    
    /// Returns `true` if the optional is nil.
    var isNil: Bool {
        self == nil
    }
    
    /// Returns `true` if the optional contains a value.
    var isNotNil: Bool {
        self != nil
    }
    
    /// Executes the closure if the optional contains a value.
    ///
    /// ```swift
    /// user?.name.apply { print("Hello, \($0)") }
    /// ```
    ///
    /// - Parameter closure: The closure to execute with the unwrapped value.
    func apply(_ closure: (Wrapped) -> Void) {
        if let value = self {
            closure(value)
        }
    }
    
    /// Returns the wrapped value or the provided default.
    ///
    /// This is equivalent to the nil-coalescing operator but can be more
    /// readable in method chains.
    ///
    /// ```swift
    /// let name = user?.name.or("Anonymous")
    /// ```
    ///
    /// - Parameter defaultValue: The value to return if the optional is nil.
    /// - Returns: The wrapped value or the default.
    func or(_ defaultValue: @autoclosure () -> Wrapped) -> Wrapped {
        self ?? defaultValue()
    }
    
    /// Returns the wrapped value or lazily evaluates the default.
    ///
    /// Use this when the default value is expensive to compute.
    ///
    /// ```swift
    /// let config = cachedConfig.or { loadConfigFromDisk() }
    /// ```
    ///
    /// - Parameter defaultValue: A closure that provides the default value.
    /// - Returns: The wrapped value or the result of the closure.
    func or(_ defaultValue: () -> Wrapped) -> Wrapped {
        if let value = self {
            return value
        }
        return defaultValue()
    }
}
