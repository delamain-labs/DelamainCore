# DelamainCore Roadmap

## v1.0.0 ✅ (Current)
- Optional extensions (`orThrow`, `isNil`, `apply`, `or`)
- Collection extensions (safe subscript, `chunked`, `unique`, `mapKeys`)
- Result extensions (`value`, `error`, `onSuccess`, `recover`)
- Comparable extensions (`clamped`)
- Concurrency utilities (`withTimeout`, `retry`)

## v1.1.0 (Planned)
### String Extensions
- [ ] `isBlank` / `isNotBlank` - whitespace-aware emptiness
- [ ] `trimmed` - returns trimmed copy
- [ ] `nilIfEmpty` - converts empty string to nil
- [ ] `truncated(to:)` - truncate with ellipsis

### Date Extensions
- [ ] Relative formatting helpers
- [ ] Start/end of day, week, month
- [ ] `isSameDay(as:)`, `isBefore(_:)`, `isAfter(_:)`

## v1.2.0 (Planned)
### Property Wrappers
- [ ] `@Clamped` - clamps values to a range
- [ ] `@Trimmed` - auto-trims string whitespace
- [ ] `@NonEmpty` - validates non-empty collections
- [ ] `@Validated` - custom validation logic

### Type-Safe Identifiers
- [ ] `Identifier<T>` - type-safe ID wrapper
- [ ] Codable conformance
- [ ] ExpressibleByStringLiteral support

## v1.3.0 (Planned)
### Advanced Concurrency
- [ ] `AsyncSequence` extensions (first, collect, etc.)
- [ ] `TaskQueue` - serial async task execution
- [ ] `Debouncer` / `Throttler` - rate limiting
- [ ] `AsyncValue` - observable async state

### Codable Helpers
- [ ] `@DefaultValue` - decode with default
- [ ] `@LossyArray` - skip failed array elements
- [ ] Date decoding strategies

## Future Considerations
- Error handling utilities
- Localization helpers
- Data formatting (bytes, numbers, etc.)
- URL construction helpers

---

*Contributions and suggestions welcome!*
