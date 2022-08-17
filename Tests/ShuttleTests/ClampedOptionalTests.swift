//
//  ClampedOptionalTests.swift
//  ShuttleTests
//

import Foundation
import XCTest
@testable import Shuttle


private let minLuminosity: Double = 1.0
private let maxLuminosity: Double = 200.0
private let minSolarSystemCount: Int = 1
private let maxSolarSystemCount: Int = 100


class ClampedOptionalTests: XCTestCase { }


// MARK: - Initialization
extension ClampedOptionalTests {
    
    func test_Initializing_WithinRange_UsesProvidedValue() throws {
        struct Galaxy {
            @ClampedOptional(to: minLuminosity...maxLuminosity)
            var luminosity: Double? = minLuminosity
        }
        
        var galaxy = Galaxy(luminosity: minLuminosity + 10)
        
        XCTAssertEqual(galaxy.luminosity, minLuminosity + 10)
        
        galaxy.luminosity = nil
        XCTAssertNil(galaxy.luminosity)
    }
}

// MARK: - Closed Range Functionality
extension ClampedOptionalTests {

    func test_ClosedRange_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Galaxy {
            @ClampedOptional(to: minLuminosity...maxLuminosity)
            var luminosity: Double? = minLuminosity
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = minLuminosity.nextUp
        
        XCTAssertEqual(galaxy.luminosity, minLuminosity.nextUp)
        
        galaxy.luminosity = nil
        XCTAssertNil(galaxy.luminosity)
    }
    
    
    func test_ClosedRange_WhenSettingBelowRange_SetsToLowerBound() throws {
        struct Galaxy {
            @ClampedOptional(to: minLuminosity...maxLuminosity)
            var luminosity: Double? = minLuminosity
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = minLuminosity.nextDown
        
        XCTAssertEqual(galaxy.luminosity, minLuminosity)
        
        galaxy.luminosity = nil
        XCTAssertNil(galaxy.luminosity)
    }
    
    
    func test_ClosedRange_WhenSettingAboveRange_SetsToUpperBound() throws {
        struct Galaxy {
            @ClampedOptional(to: minLuminosity...maxLuminosity)
            var luminosity: Double? = minLuminosity
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = maxLuminosity.nextUp
        
        XCTAssertEqual(galaxy.luminosity, maxLuminosity)
        
        galaxy.luminosity = nil
        XCTAssertNil(galaxy.luminosity)
    }
}

// MARK: - Half-Open Range Functionality
extension ClampedOptionalTests {
    
    func test_HalfOpenRange_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Planet {
            @ClampedOptional(to: 1 ..< 1025)
            var daysUntilNextYear: Int? = 1024
        }
        
        var planet = Planet()
        
        planet.daysUntilNextYear = 10

        XCTAssertEqual(planet.daysUntilNextYear, 10)
        
        planet.daysUntilNextYear = nil
        XCTAssertNil(planet.daysUntilNextYear)
    }
    
    
    func test_HalfOpenRange_WhenSettingBelowRange_SetsToLowerBound() throws {

        struct Planet {
            @ClampedOptional(to: 1 ..< 1025)
            var daysUntilNextYear: Int? = 1024
        }
        
        var planet = Planet()
        
        planet.daysUntilNextYear = -10

        XCTAssertEqual(planet.daysUntilNextYear, 1)
        
        planet.daysUntilNextYear = nil
        XCTAssertNil(planet.daysUntilNextYear)
    }
    
    
    func test_HalfOpenRange_WhenSettingAboveRange_SetsToUpperBound() throws {

        struct Planet {
            @ClampedOptional(to: 1 ..< 1025)
            var daysUntilNextYear: Int? = 1024
        }
        
        var planet = Planet()
        
        planet.daysUntilNextYear = 30310

        XCTAssertEqual(planet.daysUntilNextYear, 1025)
        
        planet.daysUntilNextYear = nil
        XCTAssertNil(planet.daysUntilNextYear)
    }
}


// MARK: - Tests: "Above and Below" Functionality
extension ClampedOptionalTests {
    
    func test_AboveAndBelow_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct AcuteTriangle {
            @ClampedOptional(
                above: 0.0,
                andBelow: .pi / 2
            )
            var vertexAngleRadians: Double? = .pi / 4
        }
        
        var triangle = AcuteTriangle()
        
        triangle.vertexAngleRadians = (.pi / 2).nextDown

        XCTAssertEqual(triangle.vertexAngleRadians, (.pi / 2).nextDown)
        
        triangle.vertexAngleRadians = nil
        XCTAssertNil(triangle.vertexAngleRadians)
    }
    
    
    func test_AboveAndBelow_WhenSettingBelowRange_SetsToLowerBound() throws {
        
        struct AcuteTriangle {
            @ClampedOptional(
                above: 0.0,
                andBelow: .pi / 2
            )
            var vertexAngleRadians: Double? = .pi / 4
        }
        
        var triangle = AcuteTriangle()
        
        triangle.vertexAngleRadians = 0.0

        XCTAssertEqual(triangle.vertexAngleRadians, 0.0.nextUp)
        
        triangle.vertexAngleRadians = nil
        XCTAssertNil(triangle.vertexAngleRadians)
    }
    
    
    func test_AboveAndBelow_WhenSettingAboveRange_SetsToUpperBound() throws {
        
        struct AcuteTriangle {
            @ClampedOptional(
                above: 0.0,
                andBelow: .pi / 2
            )
            var vertexAngleRadians: Double? = .pi / 4
        }
        
        var triangle = AcuteTriangle()
        
        triangle.vertexAngleRadians = .pi / 2

        XCTAssertEqual(triangle.vertexAngleRadians, (.pi / 2).nextDown)
        
        triangle.vertexAngleRadians = nil
        XCTAssertNil(triangle.vertexAngleRadians)
    }
}

// MARK: - `PartialRangeFrom` Functionality
extension ClampedOptionalTests {
    
    func test_PartialRangeFrom_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Galaxy {
            @ClampedOptional(to: minLuminosity...)
            var luminosity: Double? = minLuminosity
            
            @ClampedOptional(to: minSolarSystemCount...)
            var solarSystemCount: Int? = minSolarSystemCount
        }
        
        var galaxy = Galaxy()
        
        let newLuminosity = minLuminosity.nextUp
        let newSolarSystemCount = minSolarSystemCount.advanced(by: 1)
        
        galaxy.luminosity = newLuminosity
        galaxy.solarSystemCount = newSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, newLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, newSolarSystemCount)
        
        galaxy.luminosity = nil
        galaxy.solarSystemCount = nil
        
        XCTAssertNil(galaxy.luminosity)
        XCTAssertNil(galaxy.solarSystemCount)
    }
    

    func test_PartialRangeFrom_WhenSettingBelowRange_SetsToLowerBound() throws {
        
        struct Galaxy {
            @ClampedOptional(to: minLuminosity...)
            var luminosity: Double? = minLuminosity
            
            @ClampedOptional(to: minSolarSystemCount...)
            var solarSystemCount: Int? = minSolarSystemCount
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = minLuminosity.nextDown
        galaxy.solarSystemCount = minSolarSystemCount.advanced(by: -1)
        
        XCTAssertEqual(galaxy.luminosity, minLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, minSolarSystemCount)
        
        galaxy.luminosity = nil
        galaxy.solarSystemCount = nil
        
        XCTAssertNil(galaxy.luminosity)
        XCTAssertNil(galaxy.solarSystemCount)
    }
}


// MARK: - `PartialRangeUpTo` Functionality
extension ClampedOptionalTests {
    
    func test_PartialRangeUpTo_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Galaxy {
            @ClampedOptional(to: ..<maxLuminosity)
            var luminosity: Double? = .zero
            
            @ClampedOptional(to: ..<maxSolarSystemCount)
            var solarSystemCount: Int? = .zero
        }
        
        var galaxy = Galaxy()
        
        let newLuminosity = maxLuminosity.nextDown
        let newSolarSystemCount = maxSolarSystemCount.advanced(by: -1)
        
        galaxy.luminosity = newLuminosity
        galaxy.solarSystemCount = newSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, newLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, newSolarSystemCount)
        
        galaxy.luminosity = nil
        galaxy.solarSystemCount = nil
        
        XCTAssertNil(galaxy.luminosity)
        XCTAssertNil(galaxy.solarSystemCount)
    }
    

    func test_PartialRangeUpTo_WhenSettingAboveRange_SetsToUpperBound() throws {
        struct Galaxy {
            @ClampedOptional(to: ..<maxLuminosity)
            var luminosity: Double? = .zero
            
            @ClampedOptional(to: ..<maxSolarSystemCount)
            var solarSystemCount: Int? = .zero
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = maxLuminosity
        galaxy.solarSystemCount = maxSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, maxLuminosity.nextDown)
        XCTAssertEqual(galaxy.solarSystemCount, maxSolarSystemCount.advanced(by: -1))
        
        galaxy.luminosity = nil
        galaxy.solarSystemCount = nil
        
        XCTAssertNil(galaxy.luminosity)
        XCTAssertNil(galaxy.solarSystemCount)
    }
}


// MARK: - `PartialRangeThrough` Functionality
extension ClampedOptionalTests {
    
    func test_PartialRangeThrough_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Galaxy {
            @ClampedOptional(to: ...maxLuminosity)
            var luminosity: Double? = .zero
            
            @ClampedOptional(to: ...maxSolarSystemCount)
            var solarSystemCount: Int? = .zero
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = maxLuminosity
        galaxy.solarSystemCount = maxSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, maxLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, maxSolarSystemCount)
        
        galaxy.luminosity = nil
        galaxy.solarSystemCount = nil
        
        XCTAssertNil(galaxy.luminosity)
        XCTAssertNil(galaxy.solarSystemCount)
    }
    

    func test_PartialRangeThrough_WhenSettingAboveRange_SetsToUpperBound() throws {
        
        struct Galaxy {
            @ClampedOptional(to: ...maxLuminosity)
            var luminosity: Double? = .zero
            
            @ClampedOptional(to: ...maxSolarSystemCount)
            var solarSystemCount: Int? = .zero
        }
        
        var galaxy = Galaxy()
        
        let newLuminosity = maxLuminosity.nextUp
        let newSolarSystemCount = maxSolarSystemCount.advanced(by: 1)
        
        galaxy.luminosity = newLuminosity
        galaxy.solarSystemCount = newSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, maxLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, maxSolarSystemCount)
        
        galaxy.luminosity = nil
        galaxy.solarSystemCount = nil
        
        XCTAssertNil(galaxy.luminosity)
        XCTAssertNil(galaxy.solarSystemCount)
    }
}
