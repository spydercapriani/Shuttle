// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.Apps.WithID.Relationships {
	public var promotedPurchases: PromotedPurchases {
		PromotedPurchases(path: path + "/promotedPurchases")
	}

	public struct PromotedPurchases {
		/// Path: `/v1/apps/{id}/relationships/promotedPurchases`
		public let path: String

		public func get(limit: Int? = nil) -> Request<Shuttle.AppPromotedPurchasesLinkagesResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(limit), id: "apps-promotedPurchases-get_to_many_relationship")
		}

		private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(limit, forKey: "limit")
			return encoder.items
		}

		public func patch(_ body: Shuttle.AppPromotedPurchasesLinkagesRequest) -> Request<Void> {
			Request(method: "PATCH", url: path, body: body, id: "apps-promotedPurchases-replace_to_many_relationship")
		}
	}
}