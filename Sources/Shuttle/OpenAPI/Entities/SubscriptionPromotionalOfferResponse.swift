// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct SubscriptionPromotionalOfferResponse: Codable {
	/// SubscriptionPromotionalOffer
	public var data: SubscriptionPromotionalOffer
	public var included: [IncludedItem]?
	public var links: DocumentLinks

	public enum IncludedItem: Codable {
		case subscription(Subscription)
		case subscriptionPromotionalOfferPrice(SubscriptionPromotionalOfferPrice)

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let value = try? container.decode(Subscription.self) {
				self = .subscription(value)
			} else if let value = try? container.decode(SubscriptionPromotionalOfferPrice.self) {
				self = .subscriptionPromotionalOfferPrice(value)
			} else {
				throw DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to intialize `oneOf`")
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .subscription(let value): try container.encode(value)
			case .subscriptionPromotionalOfferPrice(let value): try container.encode(value)
			}
		}
	}

	public init(data: SubscriptionPromotionalOffer, included: [IncludedItem]? = nil, links: DocumentLinks) {
		self.data = data
		self.included = included
		self.links = links
	}
}
