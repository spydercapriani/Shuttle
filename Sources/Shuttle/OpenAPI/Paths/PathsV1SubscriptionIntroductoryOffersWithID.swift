// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.SubscriptionIntroductoryOffers {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/subscriptionIntroductoryOffers/{id}`
		public let path: String

		public func patch(_ body: Shuttle.SubscriptionIntroductoryOfferUpdateRequest) -> Request<Shuttle.SubscriptionIntroductoryOfferResponse> {
			Request(method: "PATCH", url: path, body: body, id: "subscriptionIntroductoryOffers-update_instance")
		}

		public var delete: Request<Void> {
			Request(method: "DELETE", url: path, id: "subscriptionIntroductoryOffers-delete_instance")
		}
	}
}
