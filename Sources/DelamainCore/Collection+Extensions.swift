// MARK: - Collection Extensions

public extension Collection {
    
    /// Safely accesses the element at the specified index.
    ///
    /// Returns `nil` if the index is out of bounds instead of crashing.
    ///
    /// ```swift
    /// let array = [1, 2, 3]
    /// array[safe: 1]  // Optional(2)
    /// array[safe: 10] // nil
    /// ```
    ///
    /// - Parameter index: The index of the element to access.
    /// - Returns: The element at the index, or nil if out of bounds.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
    /// Returns `true` if the collection is not empty.
    ///
    /// More readable than `!isEmpty` in conditionals.
    ///
    /// ```swift
    /// if items.isNotEmpty {
    ///     processItems(items)
    /// }
    /// ```
    var isNotEmpty: Bool {
        !isEmpty
    }
}

// MARK: - Array Extensions

public extension Array {
    
    /// Splits the array into chunks of the specified size.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].chunked(into: 2)
    /// // [[1, 2], [3, 4], [5]]
    /// ```
    ///
    /// - Parameter size: The maximum size of each chunk.
    /// - Returns: An array of arrays, each containing at most `size` elements.
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0, !isEmpty else { return isEmpty ? [] : [self] }
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

public extension Array where Element: Hashable {
    
    /// Returns a new array with duplicate elements removed, preserving order.
    ///
    /// ```swift
    /// [1, 2, 2, 3, 1, 4].unique() // [1, 2, 3, 4]
    /// ```
    ///
    /// - Returns: An array with duplicates removed.
    func unique() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

public extension Array {
    
    /// Returns a new array with duplicate elements removed based on a key path.
    ///
    /// ```swift
    /// struct User { let id: Int; let name: String }
    /// let users = [User(id: 1, name: "A"), User(id: 1, name: "B")]
    /// users.unique(by: \.id) // [User(id: 1, name: "A")]
    /// ```
    ///
    /// - Parameter keyPath: The key path to use for determining uniqueness.
    /// - Returns: An array with duplicates removed.
    func unique<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        var seen = Set<T>()
        return filter { seen.insert($0[keyPath: keyPath]).inserted }
    }
}

// MARK: - Dictionary Extensions

public extension Dictionary {
    
    /// Returns a new dictionary with transformed keys.
    ///
    /// ```swift
    /// ["a": 1, "b": 2].mapKeys { $0.uppercased() }
    /// // ["A": 1, "B": 2]
    /// ```
    ///
    /// - Parameter transform: A closure that transforms each key.
    /// - Returns: A dictionary with transformed keys.
    func mapKeys<T: Hashable>(_ transform: (Key) -> T) -> [T: Value] {
        Dictionary<T, Value>(uniqueKeysWithValues: map { (transform($0.key), $0.value) })
    }
}
