// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct Subscription: Codable, Identifiable {
	public var type: `Type`
	public var id: String
	public var attributes: Attributes?
	public var relationships: Relationships?
	public var links: ResourceLinks

	public enum `Type`: String, Codable, CaseIterable {
		case subscriptions
	}

	public struct Attributes: Codable {
		public var name: String?
		public var productID: String?
		public var isFamilySharable: Bool?
		public var state: State?
		public var subscriptionPeriod: SubscriptionPeriod?
		public var reviewNote: String?
		public var groupLevel: Int?
		public var isAvailableInAllTerritories: Bool?

		public enum State: String, Codable, CaseIterable {
			case missingMetadata = "MISSING_METADATA"
			case readyToSubmit = "READY_TO_SUBMIT"
			case waitingForReview = "WAITING_FOR_REVIEW"
			case inReview = "IN_REVIEW"
			case developerActionNeeded = "DEVELOPER_ACTION_NEEDED"
			case pendingBinaryApproval = "PENDING_BINARY_APPROVAL"
			case approved = "APPROVED"
			case developerRemovedFromSale = "DEVELOPER_REMOVED_FROM_SALE"
			case removedFromSale = "REMOVED_FROM_SALE"
			case rejected = "REJECTED"
		}

		public enum SubscriptionPeriod: String, Codable, CaseIterable {
			case oneWeek = "ONE_WEEK"
			case oneMonth = "ONE_MONTH"
			case twoMonths = "TWO_MONTHS"
			case threeMonths = "THREE_MONTHS"
			case sixMonths = "SIX_MONTHS"
			case oneYear = "ONE_YEAR"
		}

		public init(name: String? = nil, productID: String? = nil, isFamilySharable: Bool? = nil, state: State? = nil, subscriptionPeriod: SubscriptionPeriod? = nil, reviewNote: String? = nil, groupLevel: Int? = nil, isAvailableInAllTerritories: Bool? = nil) {
			self.name = name
			self.productID = productID
			self.isFamilySharable = isFamilySharable
			self.state = state
			self.subscriptionPeriod = subscriptionPeriod
			self.reviewNote = reviewNote
			self.groupLevel = groupLevel
			self.isAvailableInAllTerritories = isAvailableInAllTerritories
		}

		private enum CodingKeys: String, CodingKey {
			case name
			case productID = "productId"
			case isFamilySharable = "familySharable"
			case state
			case subscriptionPeriod
			case reviewNote
			case groupLevel
			case isAvailableInAllTerritories = "availableInAllTerritories"
		}
	}

	public struct Relationships: Codable {
		public var subscriptionLocalizations: SubscriptionLocalizations?
		public var appStoreReviewScreenshot: AppStoreReviewScreenshot?
		public var group: Group?
		public var introductoryOffers: IntroductoryOffers?
		public var promotionalOffers: PromotionalOffers?
		public var offerCodes: OfferCodes?
		public var prices: Prices?
		public var promotedPurchase: PromotedPurchase?

		public struct SubscriptionLocalizations: Codable {
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
					case subscriptionLocalizations
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
					case subscriptionAppStoreReviewScreenshots
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

		public struct Group: Codable {
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
					case subscriptionGroups
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

		public struct IntroductoryOffers: Codable {
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
					case subscriptionIntroductoryOffers
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

		public struct PromotionalOffers: Codable {
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
					case subscriptionPromotionalOffers
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

		public struct OfferCodes: Codable {
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
					case subscriptionOfferCodes
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

		public struct Prices: Codable {
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
					case subscriptionPrices
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

		public init(subscriptionLocalizations: SubscriptionLocalizations? = nil, appStoreReviewScreenshot: AppStoreReviewScreenshot? = nil, group: Group? = nil, introductoryOffers: IntroductoryOffers? = nil, promotionalOffers: PromotionalOffers? = nil, offerCodes: OfferCodes? = nil, prices: Prices? = nil, promotedPurchase: PromotedPurchase? = nil) {
			self.subscriptionLocalizations = subscriptionLocalizations
			self.appStoreReviewScreenshot = appStoreReviewScreenshot
			self.group = group
			self.introductoryOffers = introductoryOffers
			self.promotionalOffers = promotionalOffers
			self.offerCodes = offerCodes
			self.prices = prices
			self.promotedPurchase = promotedPurchase
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
