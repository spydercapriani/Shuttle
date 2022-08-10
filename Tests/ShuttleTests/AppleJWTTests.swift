//
//  AppleJWTTests.swift
//  ShuttleTests
//

import XCTest
@testable import Shuttle

final class AppleJWTTests: XCTestCase {

    /// It should report an invalid P8 private key.
    func testInvalidP8PrivateKey() {
        let jwt = AppleJWT(
            keyIdentifier: "941C4473-70BF-488F-A1C6-6A3F81337D0D",
            issuerIdentifier: "1000A0B5-E42D-4A0A-ACD8-9B35B7AC0DB2",
            privateKey: "&^&%^$%$%",
            expireDuration: 20
        )

        XCTAssertThrowsError(try jwt.token) { (error) in
            XCTAssertEqual(error as! AppleJWT.Error, AppleJWT.Error.invalidP8PrivateKey)
        }
    }
    
    /// It should return a valid token.
    func testValidP8PrivateKey() {
        let jwt = AppleJWT(
            keyIdentifier: "941C4473-70BF-488F-A1C6-6A3F81337D0D",
            issuerIdentifier: "1000A0B5-E42D-4A0A-ACD8-9B35B7AC0DB2",
            privateKey: "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr",
            expireDuration: 20
        )
        
        XCTAssertNoThrow(try jwt.token)
    }
}
