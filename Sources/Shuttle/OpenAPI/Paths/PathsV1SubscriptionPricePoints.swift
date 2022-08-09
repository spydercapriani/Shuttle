// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var subscriptionPricePoints: SubscriptionPricePoints {
		SubscriptionPricePoints(path: path + "/subscriptionPricePoints")
	}

	public struct SubscriptionPricePoints {
		/// Path: `/v1/subscriptionPricePoints`
		public let path: String
	}
}
