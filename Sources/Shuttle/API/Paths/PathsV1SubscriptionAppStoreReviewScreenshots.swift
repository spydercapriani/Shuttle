// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var subscriptionAppStoreReviewScreenshots: SubscriptionAppStoreReviewScreenshots {
		SubscriptionAppStoreReviewScreenshots(path: path + "/subscriptionAppStoreReviewScreenshots")
	}

	public struct SubscriptionAppStoreReviewScreenshots {
		/// Path: `/v1/subscriptionAppStoreReviewScreenshots`
		public let path: String

		public func post(_ body: Shuttle.SubscriptionAppStoreReviewScreenshotCreateRequest) -> Request<Shuttle.SubscriptionAppStoreReviewScreenshotResponse> {
			Request(method: "POST", url: path, body: body, id: "subscriptionAppStoreReviewScreenshots-create_instance")
		}
	}
}