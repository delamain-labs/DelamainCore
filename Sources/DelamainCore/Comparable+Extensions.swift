// MARK: - Comparable Extensions

public extension Comparable {
    
    /// Returns the value clamped to the specified range.
    ///
    /// ```swift
    /// let value = 15.clamped(to: 0...10) // 10
    /// let alpha = 1.5.clamped(to: 0.0...1.0) // 1.0
    /// ```
    ///
    /// - Parameter range: The closed range to clamp the value to.
    /// - Returns: The value if within range, otherwise the nearest bound.
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
