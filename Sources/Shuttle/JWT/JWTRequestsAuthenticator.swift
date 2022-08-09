//
//  JWTAuthenticator.swift
//  Shuttle
//

import Foundation
import Get

final class JWTRequestsAuthenticator {

    /// The JWT Provider to use for creating the JWT token. Can be overriden for test use cases.
    var provider: JWTProvider

    init(_ provider: JWTProvider) {
        self.provider = provider
    }
}

extension JWTRequestsAuthenticator: APIClientDelegate {
    
    public func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        request.setValue("Bearer \(try provider.token)", forHTTPHeaderField: "Authorization")
    }
}
