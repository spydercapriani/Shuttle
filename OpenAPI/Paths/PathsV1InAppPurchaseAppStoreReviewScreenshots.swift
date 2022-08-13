// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var inAppPurchaseAppStoreReviewScreenshots: InAppPurchaseAppStoreReviewScreenshots {
		InAppPurchaseAppStoreReviewScreenshots(path: path + "/inAppPurchaseAppStoreReviewScreenshots")
	}

	public struct InAppPurchaseAppStoreReviewScreenshots {
		/// Path: `/v1/inAppPurchaseAppStoreReviewScreenshots`
		public let path: String

		public func post(_ body: Shuttle.InAppPurchaseAppStoreReviewScreenshotCreateRequest) -> Request<Shuttle.InAppPurchaseAppStoreReviewScreenshotResponse> {
			Request(method: "POST", url: path, body: body, id: "inAppPurchaseAppStoreReviewScreenshots-create_instance")
		}
	}
}