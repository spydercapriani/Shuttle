//
//  ClampedOptional.swift
//  
//
//  Created by Danny Gilbert on 8/17/22.
//

import Foundation

@propertyWrapper
public struct ClampedOptional<Value: Comparable> {

    private var value: Value?
    private var range: ClosedRange<Value>

    public var wrappedValue: Value? {
        get { value }
        set { value = clampedValue(for: newValue) }
    }
}


// MARK: - Init
public extension ClampedOptional {

    init(
        wrappedValue defaultValue: Value? = nil,
        to range: ClosedRange<Value>
    ) {
        precondition(
            defaultValue != nil ? range.contains(defaultValue!) : true,
            """
            `\(defaultValue!)` is not contained by this property's
            range of `\(range)`.
            """
        )

        self.value = defaultValue
        self.range = range
    }


    /// Clamps a property to a "Half-Open" Range.
    ///
    /// Example:
    ///
    ///     @Clamped(to: 1 ..< 1025)
    ///     var score: Int = 1024
    init(
        wrappedValue defaultValue: Value?,
        to range: Range<Value>
    ) {
        precondition(
            range.lowerBound < range.upperBound,
            """
            The lower-bound of the range must be less than its upper-bound.
            """
        )

        let closedRange = ClosedRange(
            uncheckedBounds: (lower: range.lowerBound, upper: range.upperBound)
        )

        self.init(value: defaultValue, range: closedRange)
    }
}


// MARK: - Private Helpers
extension ClampedOptional {

    private func clampedValue(for newValue: Value?) -> Value? {
        guard let value = newValue else { return nil }
        return min(
            max(range.lowerBound, value),
            range.upperBound
        )
    }
}


// MARK: - `FloatingPoint` Convenience Initializers for different Range types
public extension ClampedOptional where Value: FloatingPoint {

    /// Clamps a `FloatingPoint` value to a closed range immediately above and
    /// immediately below a lower and upper threshold.
    init(
        wrappedValue defaultValue: Value? = nil,
        above oneBeforeLowerBound: Value,
        andBelow oneAfterUpperBound: Value
    ) {
        let closedRange = oneBeforeLowerBound.nextUp...oneAfterUpperBound.nextDown

        self.init(value: defaultValue, range: closedRange)
    }


    /// Clamps a `FloatingPoint` value to a closed range from a lower bound to infinity.
    init(
        wrappedValue defaultValue: Value? = nil,
        to range: PartialRangeFrom<Value>
    ) {
        let closedRange = range.lowerBound...Value.infinity

        self.init(value: defaultValue, range: closedRange)
    }


    /// Clamps a `FloatingPoint` value to a closed range from negative Infinity to
    /// a value immediately below an upper threshold.
    init(
        wrappedValue defaultValue: Value? = nil,
        to range: PartialRangeUpTo<Value>
    ) {
        let closedRange = -Value.infinity...range.upperBound.nextDown

        self.init(value: defaultValue, range: closedRange)
    }



    /// Clamps a `FloatingPoint` value to a closed range from negative Infinity to
    /// a given upper bound
    init(
        wrappedValue defaultValue: Value?,
        to range: PartialRangeThrough<Value>
    ) {
        let closedRange = -Value.infinity...range.upperBound

        self.init(value: defaultValue, range: closedRange)
    }
}


// MARK: - `FixedWidthInteger` Convenience Initializers for different Range types
public extension ClampedOptional where Value: FixedWidthInteger {

    /// Clamps a `FixedWidthInteger` value to a closed range immediately above and
    /// immediately below a lower and upper threshold.
    init(
        wrappedValue defaultValue: Value? = nil,
        above oneBeforeLowerBound: Value,
        andBelow oneAfterUpperBound: Value
    ) {
        let closedRange = (oneBeforeLowerBound + 1)...(oneAfterUpperBound - 1)

        self.init(value: defaultValue, range: closedRange)
    }


    /// Clamps a `FixedWidthInteger` value to a closed range from a lower bound to infinity.
    init(
        wrappedValue defaultValue: Value? = nil,
        to range: PartialRangeFrom<Value>
    ) {
        let closedRange = range.lowerBound...Value.max

        self.init(value: defaultValue, range: closedRange)
    }


    /// Clamps a `FixedWidthInteger` value to a closed range from negative Infinity to
    /// a value immediately below an upper threshold.
    init(
        wrappedValue defaultValue: Value? = nil,
        to range: PartialRangeUpTo<Value>
    ) {
        let closedRange = (Value.min)...(range.upperBound - 1)

        self.init(value: defaultValue, range: closedRange)
    }



    /// Clamps a `FixedWidthInteger` value to a closed range from negative Infinity to
    /// a given upper bound
    init(
        wrappedValue defaultValue: Value? = nil,
        to range: PartialRangeThrough<Value>
    ) {
        let closedRange = Value.min...range.upperBound

        self.init(value: defaultValue, range: closedRange)
    }
}
