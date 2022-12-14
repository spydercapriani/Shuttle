// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V2.InAppPurchases.WithID.Relationships {
	public var appStoreReviewScreenshot: AppStoreReviewScreenshot {
		AppStoreReviewScreenshot(path: path + "/appStoreReviewScreenshot")
	}

	public struct AppStoreReviewScreenshot {
		/// Path: `/v2/inAppPurchases/{id}/relationships/appStoreReviewScreenshot`
		public let path: String
	}
}
