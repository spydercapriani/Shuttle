// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V2 {
	public var inAppPurchases: InAppPurchases {
		InAppPurchases(path: path + "/inAppPurchases")
	}

	public struct InAppPurchases {
		/// Path: `/v2/inAppPurchases`
		public let path: String

		public func post(_ body: Shuttle.InAppPurchaseV2CreateRequest) -> Request<Shuttle.InAppPurchaseV2Response> {
			Request(method: "POST", url: path, body: body, id: "inAppPurchases-create_instance")
		}
	}
}
