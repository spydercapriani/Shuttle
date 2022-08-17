//
//  ClampedTests.swift
//  ShuttleTests
//

import Foundation
import XCTest
@testable import Shuttle


private let minLuminosity: Double = 1.0
private let maxLuminosity: Double = 200.0
private let minSolarSystemCount: Int = 1
private let maxSolarSystemCount: Int = 100


class ClampedTests: XCTestCase { }


// MARK: - Initialization
extension ClampedTests {
    
    func test_Initializing_WithinRange_UsesProvidedValue() throws {
        struct Galaxy {
            @Clamped(to: minLuminosity...maxLuminosity)
            var luminosity: Double = minLuminosity
        }
        
        let galaxy = Galaxy(luminosity: minLuminosity + 10)
        
        XCTAssertEqual(galaxy.luminosity, minLuminosity + 10)
    }
}

// MARK: - Closed Range Functionality
extension ClampedTests {

    func test_ClosedRange_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Galaxy {
            @Clamped(to: minLuminosity...maxLuminosity)
            var luminosity: Double = minLuminosity
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = minLuminosity.nextUp
        
        XCTAssertEqual(galaxy.luminosity, minLuminosity.nextUp)
    }
    
    
    func test_ClosedRange_WhenSettingBelowRange_SetsToLowerBound() throws {
        struct Galaxy {
            @Clamped(to: minLuminosity...maxLuminosity)
            var luminosity: Double = minLuminosity
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = minLuminosity.nextDown
        
        XCTAssertEqual(galaxy.luminosity, minLuminosity)
    }
    
    
    func test_ClosedRange_WhenSettingAboveRange_SetsToUpperBound() throws {
        struct Galaxy {
            @Clamped(to: minLuminosity...maxLuminosity)
            var luminosity: Double = minLuminosity
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = maxLuminosity.nextUp
        
        XCTAssertEqual(galaxy.luminosity, maxLuminosity)
    }
}

// MARK: - Half-Open Range Functionality
extension ClampedTests {
    
    func test_HalfOpenRange_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Planet {
            @Clamped(to: 1 ..< 1025)
            var daysUntilNextYear: Int = 1024
        }
        
        var planet = Planet()
        
        planet.daysUntilNextYear = 10

        XCTAssertEqual(planet.daysUntilNextYear, 10)
    }
    
    
    func test_HalfOpenRange_WhenSettingBelowRange_SetsToLowerBound() throws {

        struct Planet {
            @Clamped(to: 1 ..< 1025)
            var daysUntilNextYear: Int = 1024
        }
        
        var planet = Planet()
        
        planet.daysUntilNextYear = -10

        XCTAssertEqual(planet.daysUntilNextYear, 1)
    }
    
    
    func test_HalfOpenRange_WhenSettingAboveRange_SetsToUpperBound() throws {

        struct Planet {
            @Clamped(to: 1 ..< 1025)
            var daysUntilNextYear: Int = 1024
        }
        
        var planet = Planet()
        
        planet.daysUntilNextYear = 30310

        XCTAssertEqual(planet.daysUntilNextYear, 1025)
    }
}


// MARK: - Tests: "Above and Below" Functionality
extension ClampedTests {
    
    func test_AboveAndBelow_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct AcuteTriangle {
            @Clamped(
                above: 0.0,
                andBelow: .pi / 2
            )
            var vertexAngleRadians: Double = .pi / 4
        }
        
        var triangle = AcuteTriangle()
        
        triangle.vertexAngleRadians = (.pi / 2).nextDown

        XCTAssertEqual(triangle.vertexAngleRadians, (.pi / 2).nextDown)
    }
    
    
    func test_AboveAndBelow_WhenSettingBelowRange_SetsToLowerBound() throws {
        
        struct AcuteTriangle {
            @Clamped(
                above: 0.0,
                andBelow: .pi / 2
            )
            var vertexAngleRadians: Double = .pi / 4
        }
        
        var triangle = AcuteTriangle()
        
        triangle.vertexAngleRadians = 0.0

        XCTAssertEqual(triangle.vertexAngleRadians, 0.0.nextUp)
    }
    
    
    func test_AboveAndBelow_WhenSettingAboveRange_SetsToUpperBound() throws {
        
        struct AcuteTriangle {
            @Clamped(
                above: 0.0,
                andBelow: .pi / 2
            )
            var vertexAngleRadians: Double = .pi / 4
        }
        
        var triangle = AcuteTriangle()
        
        triangle.vertexAngleRadians = .pi / 2

        XCTAssertEqual(triangle.vertexAngleRadians, (.pi / 2).nextDown)
    }
}




// MARK: - `PartialRangeFrom` Functionality
extension ClampedTests {
    
    func test_PartialRangeFrom_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Galaxy {
            @Clamped(to: minLuminosity...)
            var luminosity: Double = minLuminosity
            
            @Clamped(to: minSolarSystemCount...)
            var solarSystemCount: Int = minSolarSystemCount
        }
        
        var galaxy = Galaxy()
        
        let newLuminosity = minLuminosity.nextUp
        let newSolarSystemCount = minSolarSystemCount.advanced(by: 1)
        
        galaxy.luminosity = newLuminosity
        galaxy.solarSystemCount = newSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, newLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, newSolarSystemCount)
    }
    

    func test_PartialRangeFrom_WhenSettingBelowRange_SetsToLowerBound() throws {
        
        struct Galaxy {
            @Clamped(to: minLuminosity...)
            var luminosity: Double = minLuminosity
            
            @Clamped(to: minSolarSystemCount...)
            var solarSystemCount: Int = minSolarSystemCount
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = minLuminosity.nextDown
        galaxy.solarSystemCount = minSolarSystemCount.advanced(by: -1)
        
        XCTAssertEqual(galaxy.luminosity, minLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, minSolarSystemCount)
    }
}


// MARK: - `PartialRangeUpTo` Functionality
extension ClampedTests {
    
    func test_PartialRangeUpTo_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Galaxy {
            @Clamped(to: ..<maxLuminosity)
            var luminosity: Double = .zero
            
            @Clamped(to: ..<maxSolarSystemCount)
            var solarSystemCount: Int = .zero
        }
        
        var galaxy = Galaxy()
        
        let newLuminosity = maxLuminosity.nextDown
        let newSolarSystemCount = maxSolarSystemCount.advanced(by: -1)
        
        galaxy.luminosity = newLuminosity
        galaxy.solarSystemCount = newSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, newLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, newSolarSystemCount)
    }
    

    func test_PartialRangeUpTo_WhenSettingAboveRange_SetsToUpperBound() throws {
        struct Galaxy {
            @Clamped(to: ..<maxLuminosity)
            var luminosity: Double = .zero
            
            @Clamped(to: ..<maxSolarSystemCount)
            var solarSystemCount: Int = .zero
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = maxLuminosity
        galaxy.solarSystemCount = maxSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, maxLuminosity.nextDown)
        XCTAssertEqual(galaxy.solarSystemCount, maxSolarSystemCount.advanced(by: -1))
    }
}


// MARK: - `PartialRangeThrough` Functionality
extension ClampedTests {
    
    func test_PartialRangeThrough_WhenSettingWithinRange_SetsToProvidedValue() throws {
        
        struct Galaxy {
            @Clamped(to: ...maxLuminosity)
            var luminosity: Double = .zero
            
            @Clamped(to: ...maxSolarSystemCount)
            var solarSystemCount: Int = .zero
        }
        
        var galaxy = Galaxy()
        
        galaxy.luminosity = maxLuminosity
        galaxy.solarSystemCount = maxSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, maxLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, maxSolarSystemCount)
    }
    

    func test_PartialRangeThrough_WhenSettingAboveRange_SetsToUpperBound() throws {
        
        struct Galaxy {
            @Clamped(to: ...maxLuminosity)
            var luminosity: Double = .zero
            
            @Clamped(to: ...maxSolarSystemCount)
            var solarSystemCount: Int = .zero
        }
        
        var galaxy = Galaxy()
        
        let newLuminosity = maxLuminosity.nextUp
        let newSolarSystemCount = maxSolarSystemCount.advanced(by: 1)
        
        galaxy.luminosity = newLuminosity
        galaxy.solarSystemCount = newSolarSystemCount
        
        XCTAssertEqual(galaxy.luminosity, maxLuminosity)
        XCTAssertEqual(galaxy.solarSystemCount, maxSolarSystemCount)
    }
}
