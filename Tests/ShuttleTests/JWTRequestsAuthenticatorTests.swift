//
//  JWTRequestsAuthenticatorTests.swift
//  ShuttleTests
//

import XCTest
import Get
import Mocker
@testable import Shuttle

final class JWTRequestsAuthenticatorTests: XCTestCase {
    
    struct FakeToken: JWTToken {
        let token: Token
        
        init(_ token: Token) {
            self.token = token
        }
    }
    
    private func createFakeToken(expireDuration: TimeInterval = 20 * 60) -> AppleJWT {
        AppleJWT(
            keyIdentifier: UUID().uuidString,
            issuerIdentifier: UUID().uuidString,
            privateKey: "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr",
            expireDuration: expireDuration
        )
    }
    
    var sampleRequest: URLRequest {
        URLRequest(url: URL(string: "www.avanderlee.com")!)
    }
    
    var fakeClient: APIClient {
        APIClient(baseURL: sampleRequest.url)
    }

    /// It should correctly set the authorization header.
    func testAuthorizationHeader() async throws {
        let provider = createFakeToken()
        let subject = JWTRequestsAuthenticator(provider)
        var request = sampleRequest
        
        try await subject.client(fakeClient, willSendRequest: &request)
        XCTAssertEqual(
            request.value(forHTTPHeaderField: "Authorization"),
            "Bearer \(try subject.token)"
        )
    }

    /// It should return the cached bearer if it's not expired.
    func testCachedBearer() async throws {
        let provider = createFakeToken()
        let subject = JWTRequestsAuthenticator(provider)
        var request1 = sampleRequest
        var request2 = sampleRequest
        
        try await subject.client(fakeClient, willSendRequest: &request1)
        try await subject.client(fakeClient, willSendRequest: &request2)
        
        XCTAssertEqual(
            request1.value(forHTTPHeaderField: "Authorization")!,
            request2.value(forHTTPHeaderField: "Authorization")!
        )
    }

    /// It should return a new token if the cached token is expired.
    func testExpiredBearer() async throws {
        let provider = createFakeToken(expireDuration: 1)
        let subject = JWTRequestsAuthenticator(provider)
        var request1 = sampleRequest
        var request2 = sampleRequest
        
        try await subject.client(fakeClient, willSendRequest: &request1)
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
        try await subject.client(fakeClient, willSendRequest: &request2)
        
        XCTAssertNotEqual(
            request1.value(forHTTPHeaderField: "Authorization")!,
            request2.value(forHTTPHeaderField: "Authorization")!
        )
    }
    
    func testShouldRetry() async throws {
        let provider = createFakeToken(expireDuration: 1)
        let subject = JWTRequestsAuthenticator(provider)
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        let sampleTask: URLSessionTask = urlSession.dataTask(with: sampleRequest.url!)
        
        /// Should return true after recieving 401 error.
        var shouldRetry = try await subject.client(
            fakeClient,
            shouldRetry: sampleTask,
            error: APIError.unacceptableStatusCode(401),
            attempts: 1
        )
        XCTAssertTrue(shouldRetry)
        
        /// Should return false after 2 attempts.
        shouldRetry = try await subject.client(
            fakeClient,
            shouldRetry: sampleTask,
            error: APIError.unacceptableStatusCode(401),
            attempts: 2
        )
        XCTAssertFalse(shouldRetry)
        
        /// Should return false for other status codes.
        shouldRetry = try await subject.client(
            fakeClient,
            shouldRetry: sampleTask,
            error: APIError.unacceptableStatusCode(404),
            attempts: 1
        )
        XCTAssertFalse(shouldRetry)
    }
}
