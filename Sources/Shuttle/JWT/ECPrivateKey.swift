//
//  ECPrivateKey.swift
//  Shuttle
//

import Foundation
import CommonCrypto

public typealias ECPrivateKey = SecKey

public extension ECPrivateKey {
    func es256Sign(digest: String) throws -> String {
        guard
            let message = digest.data(using: .utf8)
        else {
            throw AppleJWT.Error.ES256SigningFailed
        }
        
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256((message as NSData).bytes, CC_LONG(message.count), &hash)
        let digestData = Data(hash)
        let algorithm = SecKeyAlgorithm.ecdsaSignatureDigestX962SHA256
        
        guard
            SecKeyIsAlgorithmSupported(self, .sign, algorithm)
        else {
            throw AppleJWT.Error.ES256SigningFailed
        }
        
        var error: Unmanaged<CFError>?
        guard
            let signature = SecKeyCreateSignature(
                self,
                algorithm,
                digestData as CFData,
                &error
            )
        else {
            throw AppleJWT.Error.privateKeyConversionFailed
        }
        
        return try (signature as ASN1)
            .rawSignature
            .base64URLEncoded
    }
}
