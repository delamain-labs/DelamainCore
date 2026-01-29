import Testing
@testable import DelamainCore

@Suite("Collection Extensions")
struct CollectionExtensionsTests {
    
    // MARK: - Safe Subscript
    
    @Test("safe subscript returns value at valid index")
    func safeSubscriptValid() {
        let array = [1, 2, 3]
        #expect(array[safe: 1] == 2)
    }
    
    @Test("safe subscript returns nil for negative index")
    func safeSubscriptNegative() {
        let array = [1, 2, 3]
        #expect(array[safe: -1] == nil)
    }
    
    @Test("safe subscript returns nil for out of bounds index")
    func safeSubscriptOutOfBounds() {
        let array = [1, 2, 3]
        #expect(array[safe: 10] == nil)
    }
    
    @Test("safe subscript returns nil for empty array")
    func safeSubscriptEmpty() {
        let array: [Int] = []
        #expect(array[safe: 0] == nil)
    }
    
    // MARK: - isNotEmpty
    
    @Test("isNotEmpty returns true for non-empty collection")
    func isNotEmptyTrue() {
        let array = [1, 2, 3]
        #expect(array.isNotEmpty)
    }
    
    @Test("isNotEmpty returns false for empty collection")
    func isNotEmptyFalse() {
        let array: [Int] = []
        #expect(!array.isNotEmpty)
    }
}

@Suite("Array Extensions")
struct ArrayExtensionsTests {
    
    // MARK: - chunked
    
    @Test("chunked splits array into equal chunks")
    func chunkedEqualSizes() {
        let array = [1, 2, 3, 4, 5, 6]
        let chunks = array.chunked(into: 2)
        #expect(chunks == [[1, 2], [3, 4], [5, 6]])
    }
    
    @Test("chunked handles remainder")
    func chunkedWithRemainder() {
        let array = [1, 2, 3, 4, 5]
        let chunks = array.chunked(into: 2)
        #expect(chunks == [[1, 2], [3, 4], [5]])
    }
    
    @Test("chunked returns empty for empty array")
    func chunkedEmpty() {
        let array: [Int] = []
        let chunks = array.chunked(into: 2)
        #expect(chunks.isEmpty)
    }
    
    @Test("chunked with size larger than array")
    func chunkedLargeSize() {
        let array = [1, 2, 3]
        let chunks = array.chunked(into: 10)
        #expect(chunks == [[1, 2, 3]])
    }
    
    // MARK: - unique
    
    @Test("unique removes duplicates preserving order")
    func uniqueRemovesDuplicates() {
        let array = [1, 2, 2, 3, 1, 4]
        #expect(array.unique() == [1, 2, 3, 4])
    }
    
    @Test("unique returns same array when no duplicates")
    func uniqueNoDuplicates() {
        let array = [1, 2, 3, 4]
        #expect(array.unique() == [1, 2, 3, 4])
    }
    
    @Test("unique handles empty array")
    func uniqueEmpty() {
        let array: [Int] = []
        #expect(array.unique().isEmpty)
    }
    
    // MARK: - uniqueBy
    
    @Test("uniqueBy removes duplicates by key")
    func uniqueByKey() {
        struct Item: Equatable {
            let id: Int
            let name: String
        }
        let items = [
            Item(id: 1, name: "a"),
            Item(id: 2, name: "b"),
            Item(id: 1, name: "c")
        ]
        let unique = items.unique(by: \.id)
        #expect(unique.count == 2)
        #expect(unique[0].name == "a")
        #expect(unique[1].name == "b")
    }
}

@Suite("Dictionary Extensions")
struct DictionaryExtensionsTests {
    
    // MARK: - compactMapValues
    
    @Test("mapKeys transforms keys")
    func mapKeysTransforms() {
        let dict = ["a": 1, "b": 2]
        let result = dict.mapKeys { $0.uppercased() }
        #expect(result["A"] == 1)
        #expect(result["B"] == 2)
    }
}
