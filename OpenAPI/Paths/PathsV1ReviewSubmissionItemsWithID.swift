// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.ReviewSubmissionItems {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/reviewSubmissionItems/{id}`
		public let path: String

		public func patch(_ body: Shuttle.ReviewSubmissionItemUpdateRequest) -> Request<Shuttle.ReviewSubmissionItemResponse> {
			Request(method: "PATCH", url: path, body: body, id: "reviewSubmissionItems-update_instance")
		}

		public var delete: Request<Void> {
			Request(method: "DELETE", url: path, id: "reviewSubmissionItems-delete_instance")
		}
	}
}
