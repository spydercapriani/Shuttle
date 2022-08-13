// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct InAppPurchaseV2: Codable, Identifiable {
	public var type: `Type`
	public var id: String
	public var attributes: Attributes?
	public var relationships: Relationships?
	public var links: ResourceLinks

	public enum `Type`: String, Codable, CaseIterable {
		case inAppPurchases
	}

	public struct Attributes: Codable {
		public var name: String?
		public var productID: String?
		public var inAppPurchaseType: InAppPurchaseType?
		public var state: InAppPurchaseState?
		public var reviewNote: String?
		public var isFamilySharable: Bool?
		public var isContentHosting: Bool?
		public var isAvailableInAllTerritories: Bool?

		public init(name: String? = nil, productID: String? = nil, inAppPurchaseType: InAppPurchaseType? = nil, state: InAppPurchaseState? = nil, reviewNote: String? = nil, isFamilySharable: Bool? = nil, isContentHosting: Bool? = nil, isAvailableInAllTerritories: Bool? = nil) {
			self.name = name
			self.productID = productID
			self.inAppPurchaseType = inAppPurchaseType
			self.state = state
			self.reviewNote = reviewNote
			self.isFamilySharable = isFamilySharable
			self.isContentHosting = isContentHosting
			self.isAvailableInAllTerritories = isAvailableInAllTerritories
		}

		private enum CodingKeys: String, CodingKey {
			case name
			case productID = "productId"
			case inAppPurchaseType
			case state
			case reviewNote
			case isFamilySharable = "familySharable"
			case isContentHosting = "contentHosting"
			case isAvailableInAllTerritories = "availableInAllTerritories"
		}
	}

	public struct Relationships: Codable {
		public var inAppPurchaseLocalizations: InAppPurchaseLocalizations?
		public var pricePoints: PricePoints?
		public var content: Content?
		public var appStoreReviewScreenshot: AppStoreReviewScreenshot?
		public var promotedPurchase: PromotedPurchase?
		public var iapPriceSchedule: IapPriceSchedule?

		public struct InAppPurchaseLocalizations: Codable {
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
					case inAppPurchaseLocalizations
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

		public struct PricePoints: Codable {
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
					case inAppPurchasePricePoints
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

		public struct Content: Codable {
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
					case inAppPurchaseContents
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

		public struct AppStoreReviewScreenshot: Codable {
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
					case inAppPurchaseAppStoreReviewScreenshots
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

		public struct PromotedPurchase: Codable {
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
					case promotedPurchases
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

		public struct IapPriceSchedule: Codable {
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
					case inAppPurchasePriceSchedules
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

		public init(inAppPurchaseLocalizations: InAppPurchaseLocalizations? = nil, pricePoints: PricePoints? = nil, content: Content? = nil, appStoreReviewScreenshot: AppStoreReviewScreenshot? = nil, promotedPurchase: PromotedPurchase? = nil, iapPriceSchedule: IapPriceSchedule? = nil) {
			self.inAppPurchaseLocalizations = inAppPurchaseLocalizations
			self.pricePoints = pricePoints
			self.content = content
			self.appStoreReviewScreenshot = appStoreReviewScreenshot
			self.promotedPurchase = promotedPurchase
			self.iapPriceSchedule = iapPriceSchedule
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