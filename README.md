# DelamainCore

Foundational Swift utilities for the Delamain ecosystem. A collection of carefully crafted extensions and helpers that make Swift development more expressive and safe.

## Requirements

- iOS 17.0+ / macOS 14.0+ / tvOS 17.0+ / watchOS 10.0+
- Swift 6.0+
- Xcode 16.0+

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/delamain-labs/DelamainCore.git", from: "1.0.0")
]
```

Or in Xcode: File → Add Package Dependencies → Enter the repository URL.

## Features

### Optional Extensions

```swift
// Throw an error if nil
let user = try optionalUser.orThrow(UserError.notFound)

// Check nil state
if username.isNil { /* handle */ }
if username.isNotNil { /* proceed */ }

// Execute only when present
optionalConfig.apply { config in
    configure(with: config)
}

// Default values (eager and lazy)
let name = optionalName.or("Anonymous")
let config = cachedConfig.or { loadFromDisk() }
```

### Collection Extensions

```swift
// Safe subscript - never crashes
let item = array[safe: 10] // nil instead of crash

// Readable emptiness check
if items.isNotEmpty { process(items) }

// Chunking
[1, 2, 3, 4, 5].chunked(into: 2) // [[1, 2], [3, 4], [5]]

// Unique elements (preserves order)
[1, 2, 2, 3, 1].unique() // [1, 2, 3]

// Unique by key path
users.unique(by: \.id)

// Dictionary key mapping
["a": 1].mapKeys { $0.uppercased() } // ["A": 1]
```

### Result Extensions

```swift
let result: Result<User, Error> = fetchUser()

// Quick checks
if result.isSuccess { /* */ }
if result.isFailure { /* */ }

// Extract values
let user = result.value // User?
let error = result.error // Error?

// Side effects
result
    .onSuccess { user in print("Got \(user)") }
    .onFailure { error in log(error) }

// Transform errors
result.mapError { AppError.network($0) }

// Recover from errors
let count = result.map(\.itemCount).recover { _ in 0 }
```

### String Extensions

```swift
// Blank checking (whitespace-aware)
"   ".isBlank     // true
"hello".isNotBlank // true

// Trimming
"  hello  ".trimmed // "hello"

// Nil conversions
"".nilIfEmpty    // nil
"   ".nilIfBlank // nil

// Truncation
"hello world".truncated(to: 8)              // "hello..."
"hello world".truncated(to: 8, trailing: "…") // "hello w…"
```

### Date Extensions

```swift
// Start/end of day
let midnight = date.startOfDay()
let endOfDay = date.endOfDay()

// Day comparisons
date.isToday
date.isYesterday
date.isTomorrow
date.isSameDay(as: otherDate)

// Adding time
date.adding(days: 5)
date.adding(weeks: 2)
date.adding(months: 1)

// Range checks
date.isBefore(otherDate)
date.isAfter(otherDate)
date.isBetween(startDate, and: endDate)
```

### Comparable Extensions

```swift
// Clamp values to a range
15.clamped(to: 0...10) // 10
0.5.clamped(to: 0.0...1.0) // 0.5
```

### Concurrency Utilities

```swift
// Timeout for async operations
let data = try await withTimeout(seconds: 5.0) {
    try await fetchData()
}

// Retry with exponential backoff
let result = try await retry(maxAttempts: 3, delay: .seconds(1)) {
    try await unreliableOperation()
}
```

## Design Philosophy

- **Safe by default**: Prefer returning optionals over crashing
- **Expressive**: Make code read like prose
- **Minimal**: Only include utilities that earn their place
- **Swift 6 ready**: Full strict concurrency support

## License

MIT License. See [LICENSE](LICENSE) for details.
