//
//  JWT.swift
//  Shuttle
//

import Foundation

public protocol JWTProvider {
    
    var token: Token { get throws }
}

public struct AppleJWT: Codable, JWTProvider {

    public enum Error: Swift.Error, LocalizedError {

        /// In case the provided .p8 private key is of an invalid format.
        case invalidP8PrivateKey

        /// In case the private key could not be converted using the EC Algoritm
        case privateKeyConversionFailed

        /// In case the ES256 signing failed with the given digest containing the header and payload.
        case ES256SigningFailed

        /// In case the ASN1 could not be generated.
        case invalidASN1

        public var localizedDescription: String {
            switch self {
            case .invalidP8PrivateKey:
                return "The provided .p8 private key is of an invalid format"
            case .privateKeyConversionFailed:
                return "Something went wrong with converting the private key"
            case .ES256SigningFailed:
                return "Signing the digest containing the header and payload failed using the ES256 algorithm"
            case .invalidASN1:
                return "Failed to generate the ASN1 value out of the private key"
            }
        }
    }

    typealias DateProvider = () -> Date
    static let defaultDateProvider: DateProvider = { Date() }
    
    /// The JWT Header contains information specific to the App Store Connect API Keys, such as algorithm and keys.
    private struct Header: Codable {

        enum CodingKeys: String, CodingKey {
            case algorithm = "alg"
            case keyIdentifier = "kid"
            case tokenType = "typ"
        }

        /// All JWTs for App Store Connect API must be signed with ES256 encryption
        let algorithm: String = "ES256"

        /// Your private key ID from App Store Connect (Ex: 2X9R4HXF34)
        let keyIdentifier: String

        /// The required type for signing requests to the App Store Connect API
        let tokenType: String = "JWT"
    }
    /// The JWT Header contains information specific to the App Store Connect API Keys, such as algorithm and keys.
    private let header: Header

    /// Your issuer identifier from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    private let issuerIdentifier: String
    
    /// Your private API key minus the key header/footer strings.
    private let privateKey: P8PrivateKey

    /// The token's expiration duration. Tokens that expire more than 20 minutes in the future are not valid, so set it to a max of 20 minutes.
    private let expireDuration: TimeInterval

    /// Creates a new Apple JWT for creating signed requests for the App Store Connect API.
    ///
    /// - Parameters:
    ///   - keyIdentifier: Your private key ID from App Store Connect (Ex: 2X9R4HXF34)
    ///   - issuerIdentifier: Your issuer identifier from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    ///   - expireDuration: The token's expiration duration. Tokens that expire more than 20 minutes in the future are not valid, so set it to a max of 20 minutes.
    public init(
        keyIdentifier: String,
        issuerIdentifier: String,
        privateKey: P8PrivateKey,
        expireDuration: TimeInterval = 60 * 20
    ) {
        header = Header(keyIdentifier: keyIdentifier)
        self.issuerIdentifier = issuerIdentifier
        self.privateKey = privateKey
        self.expireDuration = expireDuration
    }
    
    /// Signed JWT token for App Store Connect requests.
    public var token: Token {
        get throws {
            try signedToken(using: privateKey)
        }
    }
    
    /// The JWT Payload contains information specific to the App Store Connect APIs, such as issuer ID and expiration time.
    private struct Payload: Codable {

        enum CodingKeys: String, CodingKey {
            case issuerIdentifier = "iss"
            case expirationTime = "exp"
            case audience = "aud"
        }

        /// Your issuer identifier from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
        let issuerIdentifier: String

        /// The token's expiration time, in Unix epoch time; tokens that expire more than 20 minutes in the future are not valid (Ex: 1528408800)
        let expirationTime: TimeInterval

        /// The required audience which is set to the App Store Connect version.
        let audience: String = "appstoreconnect-v1"
    }

    /// Combine the header and the payload as a digest for signing.
    private func digest(dateProvider: DateProvider) throws -> String {
        let payload = Payload(
            issuerIdentifier: issuerIdentifier,
            expirationTime: dateProvider().addingTimeInterval(expireDuration).timeIntervalSince1970
        )
        let headerString = try JSONEncoder()
            .encode(header.self)
            .base64URLEncoded
        let payloadString = try JSONEncoder()
            .encode(payload.self)
            .base64URLEncoded
        return "\(headerString).\(payloadString)"
    }

    /// Creates a signed JWT Token which can be used as a Bearer Authentication header value for signing App Store Connect API Requests.
    ///
    /// - Parameter privateKey: The .p8 private key to use for signing. You can get this value from the downloaded .p8 file.
    /// - Returns: A signed JWT.Token value which can be used as a value for the Bearer Authentication header.
    /// - Throws: An error if something went wrong, like a JWT.Error.
    func signedToken(using privateKey: P8PrivateKey, dateProvider: DateProvider = Self.defaultDateProvider) throws -> Token {
        let digest = try self.digest(dateProvider: dateProvider)

        let signature = try privateKey.asASN1
            .ECKeyData
            .privateKey
            .es256Sign(digest: digest)

        return "\(digest).\(signature)"
    }
}

internal extension Data {
    var base64URLEncoded: String {
        base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
    }
}

internal extension String {
    var base64URLDecoded: String {
        var base64 = replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        if base64.count % 4 != 0 {
            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
        }
        return base64
    }
}

public typealias Token = String
public extension Token {
    var isExpired: Bool {
        get throws {
            let decodedBearer = try JWTDecoder.decode(self)
            return decodedBearer.expiryDate.compare(Date()) != ComparisonResult.orderedDescending
        }
    }
}

public typealias P8PrivateKey = String
private extension P8PrivateKey {

    /// Converts the PEM formatted .p8 private key to a DER-encoded ASN.1 data object.
    var asASN1: ASN1 {
        get throws {
            guard let asn1 = Data(base64Encoded: self) else {
                throw AppleJWT.Error.invalidP8PrivateKey
            }
            return asn1
        }
    }
}
