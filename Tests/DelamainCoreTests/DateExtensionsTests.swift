import Testing
import Foundation
@testable import DelamainCore

@Suite("Date Extensions")
struct DateExtensionsTests {
    
    // Use a fixed calendar for predictable tests
    private var calendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "UTC")!
        return cal
    }
    
    private func makeDate(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.timeZone = TimeZone(identifier: "UTC")
        return calendar.date(from: components)!
    }
    
    // MARK: - Start/End of Day
    
    @Test("startOfDay returns midnight")
    func startOfDay() {
        let date = makeDate(year: 2026, month: 1, day: 28, hour: 14, minute: 30)
        let start = date.startOfDay(in: calendar)
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: start)
        #expect(components.hour == 0)
        #expect(components.minute == 0)
        #expect(components.second == 0)
    }
    
    @Test("endOfDay returns 23:59:59")
    func endOfDay() {
        let date = makeDate(year: 2026, month: 1, day: 28, hour: 14, minute: 30)
        let end = date.endOfDay(in: calendar)
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: end)
        #expect(components.hour == 23)
        #expect(components.minute == 59)
        #expect(components.second == 59)
    }
    
    // MARK: - isSameDay
    
    @Test("isSameDay returns true for same day different times")
    func isSameDayTrue() {
        let date1 = makeDate(year: 2026, month: 1, day: 28, hour: 9)
        let date2 = makeDate(year: 2026, month: 1, day: 28, hour: 21)
        #expect(date1.isSameDay(as: date2, in: calendar))
    }
    
    @Test("isSameDay returns false for different days")
    func isSameDayFalse() {
        let date1 = makeDate(year: 2026, month: 1, day: 28)
        let date2 = makeDate(year: 2026, month: 1, day: 29)
        #expect(!date1.isSameDay(as: date2, in: calendar))
    }
    
    // MARK: - isToday / isYesterday / isTomorrow
    
    @Test("isToday returns true for current date")
    func isToday() {
        let now = Date()
        #expect(now.isToday)
    }
    
    @Test("isYesterday returns true for yesterday")
    func isYesterday() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        #expect(yesterday.isYesterday)
    }
    
    @Test("isTomorrow returns true for tomorrow")
    func isTomorrow() {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        #expect(tomorrow.isTomorrow)
    }
    
    // MARK: - Adding Components
    
    @Test("adding days works correctly")
    func addingDays() {
        let date = makeDate(year: 2026, month: 1, day: 28)
        let result = date.adding(days: 5, in: calendar)
        
        let components = calendar.dateComponents([.year, .month, .day], from: result)
        #expect(components.day == 2)
        #expect(components.month == 2)
    }
    
    @Test("adding negative days works correctly")
    func addingNegativeDays() {
        let date = makeDate(year: 2026, month: 1, day: 5)
        let result = date.adding(days: -10, in: calendar)
        
        let components = calendar.dateComponents([.year, .month, .day], from: result)
        #expect(components.day == 26)
        #expect(components.month == 12)
        #expect(components.year == 2025)
    }
    
    @Test("adding weeks works correctly")
    func addingWeeks() {
        let date = makeDate(year: 2026, month: 1, day: 1)
        let result = date.adding(weeks: 2, in: calendar)
        
        let components = calendar.dateComponents([.day], from: result)
        #expect(components.day == 15)
    }
    
    @Test("adding months works correctly")
    func addingMonths() {
        let date = makeDate(year: 2026, month: 1, day: 28)
        let result = date.adding(months: 3, in: calendar)
        
        let components = calendar.dateComponents([.month], from: result)
        #expect(components.month == 4)
    }
    
    // MARK: - Comparisons
    
    @Test("isBefore returns true for earlier date")
    func isBeforeTrue() {
        let date1 = makeDate(year: 2026, month: 1, day: 1)
        let date2 = makeDate(year: 2026, month: 1, day: 2)
        #expect(date1.isBefore(date2))
    }
    
    @Test("isBefore returns false for same date")
    func isBeforeFalseSame() {
        let date = makeDate(year: 2026, month: 1, day: 1)
        #expect(!date.isBefore(date))
    }
    
    @Test("isAfter returns true for later date")
    func isAfterTrue() {
        let date1 = makeDate(year: 2026, month: 1, day: 2)
        let date2 = makeDate(year: 2026, month: 1, day: 1)
        #expect(date1.isAfter(date2))
    }
    
    @Test("isBetween returns true when in range")
    func isBetweenTrue() {
        let start = makeDate(year: 2026, month: 1, day: 1)
        let end = makeDate(year: 2026, month: 1, day: 31)
        let date = makeDate(year: 2026, month: 1, day: 15)
        #expect(date.isBetween(start, and: end))
    }
    
    @Test("isBetween returns false when outside range")
    func isBetweenFalse() {
        let start = makeDate(year: 2026, month: 1, day: 1)
        let end = makeDate(year: 2026, month: 1, day: 31)
        let date = makeDate(year: 2026, month: 2, day: 15)
        #expect(!date.isBetween(start, and: end))
    }
}
