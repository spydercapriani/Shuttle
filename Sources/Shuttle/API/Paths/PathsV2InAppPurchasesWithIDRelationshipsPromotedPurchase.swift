// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V2.InAppPurchases.WithID.Relationships {
	public var promotedPurchase: PromotedPurchase {
		PromotedPurchase(path: path + "/promotedPurchase")
	}

	public struct PromotedPurchase {
		/// Path: `/v2/inAppPurchases/{id}/relationships/promotedPurchase`
		public let path: String
	}
}