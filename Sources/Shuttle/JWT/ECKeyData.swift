//
//  ECKeyData.swift
//  Shuttle
//

import Foundation

public typealias ECKeyData = Data

public extension ECKeyData {
    func toPrivateKey() throws -> ECPrivateKey {
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
            throw JWT.Error.privateKeyConversionFailed
        }
        return privateKey
    }
    
    func toPublicKey() throws -> ECPrivateKey {
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
            throw JWT.Error.privateKeyConversionFailed
        }
        return publicKey
    }
}
