// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct SubscriptionOfferCodePrice: Codable, Identifiable {
	public var type: `Type`
	public var id: String
	public var relationships: Relationships?
	public var links: ResourceLinks

	public enum `Type`: String, Codable, CaseIterable {
		case subscriptionOfferCodePrices
	}

	public struct Relationships: Codable {
		public var territory: Territory?
		public var subscriptionPricePoint: SubscriptionPricePoint?

		public struct Territory: Codable {
			public var links: Links?
			public var data: Data?

			public struct Links: Codable {
				public var this: String?
				public var related: String?

				public init(this: String? = nil, related: String? = nil) {
					self.this = this
					self.related = related
				}

				private enum CodingKeys: String, CodingKey {
					case this = "self"
					case related
				}
			}

			public struct Data: Codable, Identifiable {
				public var type: `Type`
				public var id: String

				public enum `Type`: String, Codable, CaseIterable {
					case territories
				}

				public init(type: `Type`, id: String) {
					self.type = type
					self.id = id
				}
			}

			public init(links: Links? = nil, data: Data? = nil) {
				self.links = links
				self.data = data
			}
		}

		public struct SubscriptionPricePoint: Codable {
			public var links: Links?
			public var data: Data?

			public struct Links: Codable {
				public var this: String?
				public var related: String?

				public init(this: String? = nil, related: String? = nil) {
					self.this = this
					self.related = related
				}

				private enum CodingKeys: String, CodingKey {
					case this = "self"
					case related
				}
			}

			public struct Data: Codable, Identifiable {
				public var type: `Type`
				public var id: String

				public enum `Type`: String, Codable, CaseIterable {
					case subscriptionPricePoints
				}

				public init(type: `Type`, id: String) {
					self.type = type
					self.id = id
				}
			}

			public init(links: Links? = nil, data: Data? = nil) {
				self.links = links
				self.data = data
			}
		}

		public init(territory: Territory? = nil, subscriptionPricePoint: SubscriptionPricePoint? = nil) {
			self.territory = territory
			self.subscriptionPricePoint = subscriptionPricePoint
		}
	}

	public init(type: `Type`, id: String, relationships: Relationships? = nil, links: ResourceLinks) {
		self.type = type
		self.id = id
		self.relationships = relationships
		self.links = links
	}
}
