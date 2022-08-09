// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct SubscriptionOfferCodeCustomCodeResponse: Codable {
	/// SubscriptionOfferCodeCustomCode
	public var data: SubscriptionOfferCodeCustomCode
	public var included: [SubscriptionOfferCode]?
	public var links: DocumentLinks

	public init(data: SubscriptionOfferCodeCustomCode, included: [SubscriptionOfferCode]? = nil, links: DocumentLinks) {
		self.data = data
		self.included = included
		self.links = links
	}
}
