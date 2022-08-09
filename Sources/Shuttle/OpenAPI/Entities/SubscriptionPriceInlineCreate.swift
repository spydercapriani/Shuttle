// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct SubscriptionPriceInlineCreate: Codable, Identifiable {
	public var type: `Type`
	public var id: String?
	public var attributes: Attributes?
	public var relationships: Relationships?

	public enum `Type`: String, Codable, CaseIterable {
		case subscriptionPrices
	}

	public struct Attributes: Codable {
		public var startDate: String?
		public var isPreserveCurrentPrice: Bool?

		public init(startDate: String? = nil, isPreserveCurrentPrice: Bool? = nil) {
			self.startDate = startDate
			self.isPreserveCurrentPrice = isPreserveCurrentPrice
		}

		private enum CodingKeys: String, CodingKey {
			case startDate
			case isPreserveCurrentPrice = "preserveCurrentPrice"
		}
	}

	public struct Relationships: Codable {
		public var subscription: Subscription?
		public var territory: Territory?
		public var subscriptionPricePoint: SubscriptionPricePoint?

		public struct Subscription: Codable {
			public var data: Data?

			public struct Data: Codable, Identifiable {
				public var type: `Type`
				public var id: String

				public enum `Type`: String, Codable, CaseIterable {
					case subscriptions
				}

				public init(type: `Type`, id: String) {
					self.type = type
					self.id = id
				}
			}

			public init(data: Data? = nil) {
				self.data = data
			}
		}

		public struct Territory: Codable {
			public var data: Data?

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

			public init(data: Data? = nil) {
				self.data = data
			}
		}

		public struct SubscriptionPricePoint: Codable {
			public var data: Data?

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

			public init(data: Data? = nil) {
				self.data = data
			}
		}

		public init(subscription: Subscription? = nil, territory: Territory? = nil, subscriptionPricePoint: SubscriptionPricePoint? = nil) {
			self.subscription = subscription
			self.territory = territory
			self.subscriptionPricePoint = subscriptionPricePoint
		}
	}

	public init(type: `Type`, id: String? = nil, attributes: Attributes? = nil, relationships: Relationships? = nil) {
		self.type = type
		self.id = id
		self.attributes = attributes
		self.relationships = relationships
	}
}
