//
//  ClientTests.swift
//  ShuttleTests
//

import XCTest
import Get
import Mocker
@testable import Shuttle

final class ClientTests: XCTestCase {
    
    //    private struct MockRequestExecutor<T>: RequestExecutor {
    //
    //        let expectedResponse: Result<Response<T>, Swift.Error>
    //
    //        init(expectedResponse: Result<Response<T>, Swift.Error>) {
    //            self.expectedResponse = expectedResponse
    //        }
    //
    //        func execute(_ urlRequest: URLRequest, completion: @escaping (Result<Response<Data>, Swift.Error>) -> Void) {
    //            if let response = expectedResponse as? Result<Response<Data>, Swift.Error> {
    //                completion(response)
    //            }
    //        }
    //
    //        func execute(_ request: URLRequest) async throws -> Response<Data> {
    //            try expectedResponse.get() as! Response<Data>
    //        }
    //
    //        func retrieve(_ url: URL, completion: @escaping (Result<Response<Data>, Swift.Error>) -> Void) {
    //            if let response = expectedResponse as? Result<Response<Data>, Swift.Error> {
    //                completion(response)
    //            }
    //        }
    //
    //        func download(_ urlRequest: URLRequest, completion: @escaping (Result<Response<URL>, Error>) -> Void) {
    //            if let response = expectedResponse as? Result<Response<URL>, Swift.Error> {
    //                completion(response)
    //            }
    //        }
    //
    //        func download(_ request: URLRequest) async throws -> Response<URL> {
    //            try expectedResponse.get() as! Response<URL>
    //        }
    //    }
    
    private let provider = AppleJWT(
        keyIdentifier: UUID().uuidString,
        issuerIdentifier: UUID().uuidString,
        privateKey: "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr"
    )
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        AppStoreConnect.client = APIClient(
            baseURL: URL(string: "https://api.appstoreconnect.apple.com"),
            sessionConfiguration: configuration,
            provider: provider
        )
    }
    
    // MARK: - Tests
    func testRequestWithVoidResponse() async throws {
        let request = AppStoreConnect
            .v1
            .profiles
            .id("test_profile_id")
            .delete
        
        let url = try await AppStoreConnect.client
            .makeURLRequest(for: request)
            .url!
        
        let mockResponse = Mock(
            url: url,
            dataType: .json,
            statusCode: 200,
            data: [
                .delete: Data()
            ]
        )
        mockResponse.register()
        
        try await request.value
    }
    
    func testRequestWithValueResponse() async throws {
        let request = AppStoreConnect
            .v1
            .profiles
            .id("test_profile_id")
            .get()
        
        let url = try await AppStoreConnect.client
            .makeURLRequest(for: request)
            .url!
        
        let expectedResponse = ProfileResponse(
            data: .init(
                type: .profiles,
                id: "test_profile_id",
                attributes: .init(
                    name: "test_profile",
                    platform: .ios,
                    profileType: .iosAppDevelopment,
                    profileState: .active,
                    profileContent: "fake_content",
                    uuid: UUID().uuidString,
                    createdDate: Date(),
                    expirationDate: Date()
                ),
                links: .init(this: "https://this.profile.com")
            ),
            included: nil,
            links: .init(this: "https://this.profile.com")
        )
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let expectedProfileData = try encoder.encode(expectedResponse)
        
        let mockResponse = Mock(
            url: url,
            dataType: .json,
            statusCode: 200,
            data: [
                .get: expectedProfileData
            ]
        )
        mockResponse.register()
        
        let profile = try await request.value.data
        XCTAssertEqual(
            profile.id,
            expectedResponse.data.id
        )
    }
    
    func testRequestWithErrorResponse() async throws {
        let request = AppStoreConnect
            .v1
            .profiles
            .id("test_profile")
            .delete
        
        let url = try await AppStoreConnect.client
            .makeURLRequest(for: request)
            .url!
        
        let errorResponse = ErrorResponse(errors: [
            .init(
                id: UUID().uuidString,
                status: "404",
                code: "NOT_FOUND",
                title: "The specified resource does not exist",
                detail: "There is no resource of type 'profiles' with id 'test_profile'"
            )
        ])
        let errorResponseData = try JSONEncoder().encode(errorResponse)
        
        let mockResponse = Mock(
            url: url,
            dataType: .json,
            statusCode: 404,
            data: [
                .delete: errorResponseData
            ]
        )
        mockResponse.register()
        
        let requestTask = Task {
            try await request.value
        }
        
        let result = await requestTask.result
        
        XCTAssertThrowsError(try result.get(), "Expected to fail!") { error in
            XCTAssertEqual(
                error as! APIError,
                .unacceptableStatusCode(404)
            )
        }
    }
}

extension APIError: Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (
            let .unacceptableStatusCode(lhsStatusCode),
            let .unacceptableStatusCode(rhsStatusCode)
        ):
            return lhsStatusCode == rhsStatusCode
        }
    }
}
