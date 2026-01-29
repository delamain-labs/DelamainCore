import Testing
@testable import DelamainCore

@Suite("Comparable Extensions")
struct ComparableExtensionsTests {
    
    // MARK: - clamped
    
    @Test("clamped returns value when within range")
    func clampedWithinRange() {
        #expect(5.clamped(to: 0...10) == 5)
    }
    
    @Test("clamped returns lower bound when below range")
    func clampedBelowRange() {
        #expect((-5).clamped(to: 0...10) == 0)
    }
    
    @Test("clamped returns upper bound when above range")
    func clampedAboveRange() {
        #expect(15.clamped(to: 0...10) == 10)
    }
    
    @Test("clamped works with doubles")
    func clampedDoubles() {
        #expect(0.5.clamped(to: 0.0...1.0) == 0.5)
        #expect((-0.5).clamped(to: 0.0...1.0) == 0.0)
        #expect(1.5.clamped(to: 0.0...1.0) == 1.0)
    }
    
    @Test("clamped at boundary values")
    func clampedAtBoundary() {
        #expect(0.clamped(to: 0...10) == 0)
        #expect(10.clamped(to: 0...10) == 10)
    }
}
