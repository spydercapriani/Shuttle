// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct PromotedPurchase: Codable, Identifiable {
	public var type: `Type`
	public var id: String
	public var attributes: Attributes?
	public var relationships: Relationships?
	public var links: ResourceLinks

	public enum `Type`: String, Codable, CaseIterable {
		case promotedPurchases
	}

	public struct Attributes: Codable {
		public var isVisibleForAllUsers: Bool?
		public var isEnabled: Bool?
		public var state: State?

		public enum State: String, Codable, CaseIterable {
			case approved = "APPROVED"
			case inReview = "IN_REVIEW"
			case prepareForSubmission = "PREPARE_FOR_SUBMISSION"
			case rejected = "REJECTED"
		}

		public init(isVisibleForAllUsers: Bool? = nil, isEnabled: Bool? = nil, state: State? = nil) {
			self.isVisibleForAllUsers = isVisibleForAllUsers
			self.isEnabled = isEnabled
			self.state = state
		}

		private enum CodingKeys: String, CodingKey {
			case isVisibleForAllUsers = "visibleForAllUsers"
			case isEnabled = "enabled"
			case state
		}
	}

	public struct Relationships: Codable {
		public var inAppPurchaseV2: InAppPurchaseV2?
		public var subscription: Subscription?
		public var promotionImages: PromotionImages?

		public struct InAppPurchaseV2: Codable {
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
					case inAppPurchases
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

		public struct Subscription: Codable {
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
					case subscriptions
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

		public struct PromotionImages: Codable {
			public var links: Links?
			public var meta: PagingInformation?
			public var data: [Datum]?

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

			public struct Datum: Codable, Identifiable {
				public var type: `Type`
				public var id: String

				public enum `Type`: String, Codable, CaseIterable {
					case promotedPurchaseImages
				}

				public init(type: `Type`, id: String) {
					self.type = type
					self.id = id
				}
			}

			public init(links: Links? = nil, meta: PagingInformation? = nil, data: [Datum]? = nil) {
				self.links = links
				self.meta = meta
				self.data = data
			}
		}

		public init(inAppPurchaseV2: InAppPurchaseV2? = nil, subscription: Subscription? = nil, promotionImages: PromotionImages? = nil) {
			self.inAppPurchaseV2 = inAppPurchaseV2
			self.subscription = subscription
			self.promotionImages = promotionImages
		}
	}

	public init(type: `Type`, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks) {
		self.type = type
		self.id = id
		self.attributes = attributes
		self.relationships = relationships
		self.links = links
	}
}
