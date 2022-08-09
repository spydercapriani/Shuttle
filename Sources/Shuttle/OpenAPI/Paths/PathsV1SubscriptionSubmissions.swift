// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var subscriptionSubmissions: SubscriptionSubmissions {
		SubscriptionSubmissions(path: path + "/subscriptionSubmissions")
	}

	public struct SubscriptionSubmissions {
		/// Path: `/v1/subscriptionSubmissions`
		public let path: String

		public func post(_ body: Shuttle.SubscriptionSubmissionCreateRequest) -> Request<Shuttle.SubscriptionSubmissionResponse> {
			Request(method: "POST", url: path, body: body, id: "subscriptionSubmissions-create_instance")
		}
	}
}