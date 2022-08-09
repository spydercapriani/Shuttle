// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppEventUpdateRequest: Codable {
	public var data: Data

	public struct Data: Codable, Identifiable {
		public var type: `Type`
		public var id: String
		public var attributes: Attributes?

		public enum `Type`: String, Codable, CaseIterable {
			case appEvents
		}

		public struct Attributes: Codable {
			public var referenceName: String?
			public var badge: Badge?
			public var deepLink: URL?
			public var purchaseRequirement: PurchaseRequirement?
			public var primaryLocale: String?
			public var priority: Priority?
			public var purpose: Purpose?
			public var territorySchedules: [TerritorySchedule]?

			public enum Badge: String, Codable, CaseIterable {
				case liveEvent = "LIVE_EVENT"
				case premiere = "PREMIERE"
				case challenge = "CHALLENGE"
				case competition = "COMPETITION"
				case newSeason = "NEW_SEASON"
				case majorUpdate = "MAJOR_UPDATE"
				case specialEvent = "SPECIAL_EVENT"
			}

			public enum PurchaseRequirement: String, Codable, CaseIterable {
				case noCostAssociated = "NO_COST_ASSOCIATED"
				case inAppPurchase = "IN_APP_PURCHASE"
				case subscription = "SUBSCRIPTION"
				case inAppPurchaseAndSubscription = "IN_APP_PURCHASE_AND_SUBSCRIPTION"
				case inAppPurchaseOrSubscription = "IN_APP_PURCHASE_OR_SUBSCRIPTION"
			}

			public enum Priority: String, Codable, CaseIterable {
				case high = "HIGH"
				case normal = "NORMAL"
			}

			public enum Purpose: String, Codable, CaseIterable {
				case appropriateForAllUsers = "APPROPRIATE_FOR_ALL_USERS"
				case attractNewUsers = "ATTRACT_NEW_USERS"
				case keepActiveUsersInformed = "KEEP_ACTIVE_USERS_INFORMED"
				case bringBackLapsedUsers = "BRING_BACK_LAPSED_USERS"
			}

			public struct TerritorySchedule: Codable {
				public var territories: [String]?
				public var publishStart: Date?
				public var eventStart: Date?
				public var eventEnd: Date?

				public init(territories: [String]? = nil, publishStart: Date? = nil, eventStart: Date? = nil, eventEnd: Date? = nil) {
					self.territories = territories
					self.publishStart = publishStart
					self.eventStart = eventStart
					self.eventEnd = eventEnd
				}
			}

			public init(referenceName: String? = nil, badge: Badge? = nil, deepLink: URL? = nil, purchaseRequirement: PurchaseRequirement? = nil, primaryLocale: String? = nil, priority: Priority? = nil, purpose: Purpose? = nil, territorySchedules: [TerritorySchedule]? = nil) {
				self.referenceName = referenceName
				self.badge = badge
				self.deepLink = deepLink
				self.purchaseRequirement = purchaseRequirement
				self.primaryLocale = primaryLocale
				self.priority = priority
				self.purpose = purpose
				self.territorySchedules = territorySchedules
			}
		}

		public init(type: `Type`, id: String, attributes: Attributes? = nil) {
			self.type = type
			self.id = id
			self.attributes = attributes
		}
	}

	public init(data: Data) {
		self.data = data
	}
}
