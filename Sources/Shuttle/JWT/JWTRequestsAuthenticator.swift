//
//  JWTAuthenticator.swift
//  Shuttle
//

import Foundation
import Get

final class JWTRequestsAuthenticator {

    /// The JWT Token to use for creating requests. Can be overriden for test use cases.
    var provider: JWTToken

    init(_ token: JWTToken) {
        self.provider = token
    }
}

// MARK: - APIClientDelegate
extension JWTRequestsAuthenticator: APIClientDelegate {
    
    public func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        request.setValue("Bearer \(try provider.token)", forHTTPHeaderField: "Authorization")
    }
}
