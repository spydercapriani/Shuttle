//
//  ECKeyData.swift
//  Shuttle
//

import Foundation

public typealias ECKeyData = Data

public extension ECKeyData {
    var privateKey: ECPrivateKey {
        get throws {
            var error: Unmanaged<CFError>?
            
            guard
                let privateKey = SecKeyCreateWithData(
                    self as CFData,
                    [
                        kSecAttrKeyType: kSecAttrKeyTypeECSECPrimeRandom,
                        kSecAttrKeyClass: kSecAttrKeyClassPrivate,
                        kSecAttrKeySizeInBits: 256
                    ] as CFDictionary,
                    &error)
            else {
                throw AppleJWT.Error.privateKeyConversionFailed
            }
            return privateKey
        }
    }
    
    var publicKey: ECPrivateKey {
        get throws {
            var error: Unmanaged<CFError>?
            
            guard
                let publicKey = SecKeyCreateWithData(
                    self as CFData,
                    [
                        kSecAttrKeyType: kSecAttrKeyTypeECSECPrimeRandom,
                        kSecAttrKeyClass: kSecAttrKeyClassPublic,
                        kSecAttrKeySizeInBits: 256
                    ] as CFDictionary,
                    &error
                )
            else {
                throw AppleJWT.Error.privateKeyConversionFailed
            }
            return publicKey
        }
    }
}
