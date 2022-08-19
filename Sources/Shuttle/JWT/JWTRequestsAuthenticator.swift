//
//  JWTAuthenticator.swift
//  Shuttle
//

import Foundation
import Get

public final class JWTRequestsAuthenticator {
    
    /// The JWT Token to use for creating requests. Can be overriden for test use cases.
    private let provider: JWTToken
    
    private(set) var cached_token: Token?
    public var token: Token {
        get throws {
            guard
                let validToken = cached_token,
                try !validToken.isExpired
            else {
                let newToken = try provider.value
                cached_token = newToken
                return newToken
            }
            return validToken
        }
    }
    
    public init(_ token: JWTToken) {
        self.provider = token
    }
}

// MARK: - APIClientDelegate
extension JWTRequestsAuthenticator: APIClientDelegate {
    
    /// Adds the Authorization header with signed JWT Token.
    public func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        request.setValue("Bearer \(try token)", forHTTPHeaderField: "Authorization")
    }
    
    /// Retries 401 responses one more time in case token just expired.
    public func client(_ client: APIClient, shouldRetry task: URLSessionTask, error: Error, attempts: Int) async throws -> Bool {
        if case .unacceptableStatusCode(let statusCode) = error as? APIError,
           statusCode == 401, attempts == 1 {
            return true
        }
        return false
    }
}
