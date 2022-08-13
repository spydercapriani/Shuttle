// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var appStoreReviewAttachments: AppStoreReviewAttachments {
		AppStoreReviewAttachments(path: path + "/appStoreReviewAttachments")
	}

	public struct AppStoreReviewAttachments {
		/// Path: `/v1/appStoreReviewAttachments`
		public let path: String

		public func post(_ body: Shuttle.AppStoreReviewAttachmentCreateRequest) -> Request<Shuttle.AppStoreReviewAttachmentResponse> {
			Request(method: "POST", url: path, body: body, id: "appStoreReviewAttachments-create_instance")
		}
	}
}