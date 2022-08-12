// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var appClipAppStoreReviewDetails: AppClipAppStoreReviewDetails {
		AppClipAppStoreReviewDetails(path: path + "/appClipAppStoreReviewDetails")
	}

	public struct AppClipAppStoreReviewDetails {
		/// Path: `/v1/appClipAppStoreReviewDetails`
		public let path: String

		public func post(_ body: Shuttle.AppClipAppStoreReviewDetailCreateRequest) -> Request<Shuttle.AppClipAppStoreReviewDetailResponse> {
			Request(method: "POST", url: path, body: body, id: "appClipAppStoreReviewDetails-create_instance")
		}
	}
}