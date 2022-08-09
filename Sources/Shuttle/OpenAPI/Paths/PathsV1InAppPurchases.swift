// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var inAppPurchases: InAppPurchases {
		InAppPurchases(path: path + "/inAppPurchases")
	}

	public struct InAppPurchases {
		/// Path: `/v1/inAppPurchases`
		public let path: String
	}
}
