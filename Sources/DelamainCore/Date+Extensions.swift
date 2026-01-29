import Foundation

// MARK: - Date Extensions

public extension Date {
    
    // MARK: - Start/End of Day
    
    /// Returns the start of the day (midnight) for this date.
    ///
    /// ```swift
    /// let midnight = date.startOfDay()
    /// ```
    ///
    /// - Parameter calendar: The calendar to use. Defaults to current.
    /// - Returns: The date at midnight.
    func startOfDay(in calendar: Calendar = .current) -> Date {
        calendar.startOfDay(for: self)
    }
    
    /// Returns the end of the day (23:59:59) for this date.
    ///
    /// ```swift
    /// let endOfDay = date.endOfDay()
    /// ```
    ///
    /// - Parameter calendar: The calendar to use. Defaults to current.
    /// - Returns: The date at 23:59:59.
    func endOfDay(in calendar: Calendar = .current) -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfDay(in: calendar))!
    }
    
    // MARK: - Day Comparisons
    
    /// Returns `true` if this date is on the same day as another date.
    ///
    /// ```swift
    /// let morning = // 9:00 AM today
    /// let evening = // 9:00 PM today
    /// morning.isSameDay(as: evening) // true
    /// ```
    ///
    /// - Parameters:
    ///   - other: The date to compare with.
    ///   - calendar: The calendar to use. Defaults to current.
    /// - Returns: `true` if both dates are on the same calendar day.
    func isSameDay(as other: Date, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, inSameDayAs: other)
    }
    
    /// Returns `true` if this date is today.
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    /// Returns `true` if this date is yesterday.
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
    
    /// Returns `true` if this date is tomorrow.
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    // MARK: - Adding Components
    
    /// Returns a new date by adding days to this date.
    ///
    /// ```swift
    /// let nextWeek = date.adding(days: 7)
    /// let lastWeek = date.adding(days: -7)
    /// ```
    ///
    /// - Parameters:
    ///   - days: The number of days to add (can be negative).
    ///   - calendar: The calendar to use. Defaults to current.
    /// - Returns: The new date.
    func adding(days: Int, in calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    /// Returns a new date by adding weeks to this date.
    ///
    /// - Parameters:
    ///   - weeks: The number of weeks to add (can be negative).
    ///   - calendar: The calendar to use. Defaults to current.
    /// - Returns: The new date.
    func adding(weeks: Int, in calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: .weekOfYear, value: weeks, to: self)!
    }
    
    /// Returns a new date by adding months to this date.
    ///
    /// - Parameters:
    ///   - months: The number of months to add (can be negative).
    ///   - calendar: The calendar to use. Defaults to current.
    /// - Returns: The new date.
    func adding(months: Int, in calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: .month, value: months, to: self)!
    }
    
    // MARK: - Comparisons
    
    /// Returns `true` if this date is before another date.
    ///
    /// - Parameter other: The date to compare with.
    /// - Returns: `true` if this date is earlier.
    func isBefore(_ other: Date) -> Bool {
        self < other
    }
    
    /// Returns `true` if this date is after another date.
    ///
    /// - Parameter other: The date to compare with.
    /// - Returns: `true` if this date is later.
    func isAfter(_ other: Date) -> Bool {
        self > other
    }
    
    /// Returns `true` if this date is between two other dates (inclusive).
    ///
    /// ```swift
    /// let jan15 = // January 15
    /// let jan1 = // January 1
    /// let jan31 = // January 31
    /// jan15.isBetween(jan1, and: jan31) // true
    /// ```
    ///
    /// - Parameters:
    ///   - start: The start date of the range.
    ///   - end: The end date of the range.
    /// - Returns: `true` if this date is within the range.
    func isBetween(_ start: Date, and end: Date) -> Bool {
        self >= start && self <= end
    }
}
