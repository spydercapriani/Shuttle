// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.Apps.WithID {
	public var inAppPurchasesV2: InAppPurchasesV2 {
		InAppPurchasesV2(path: path + "/inAppPurchasesV2")
	}

	public struct InAppPurchasesV2 {
		/// Path: `/v1/apps/{id}/inAppPurchasesV2`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<Shuttle.InAppPurchasesV2Response> {
			Request(method: "GET", url: path, query: parameters?.asQuery, id: "apps-inAppPurchasesV2-get_to_many_related")
		}

		public struct GetParameters {
			public var filterInAppPurchaseType: [FilterInAppPurchaseType]?
			public var filterName: [String]?
			public var filterProductID: [String]?
			public var filterState: [FilterState]?
			public var sort: [Sort]?
			public var fieldsInAppPurchaseAppStoreReviewScreenshots: [FieldsInAppPurchaseAppStoreReviewScreenshots]?
			public var fieldsInAppPurchasePricePoints: [FieldsInAppPurchasePricePoints]?
			public var fieldsPromotedPurchases: [FieldsPromotedPurchases]?
			public var fieldsInAppPurchaseLocalizations: [FieldsInAppPurchaseLocalizations]?
			public var fieldsInAppPurchases: [FieldsInAppPurchases]?
			public var fieldsInAppPurchasePriceSchedules: [FieldsInAppPurchasePriceSchedules]?
			public var fieldsInAppPurchaseContents: [FieldsInAppPurchaseContents]?
			public var limit: Int?
			public var limitInAppPurchaseLocalizations: Int?
			public var limitPricePoints: Int?
			public var include: [Include]?

			public enum FilterInAppPurchaseType: String, Codable, CaseIterable {
				case consumable = "CONSUMABLE"
				case nonConsumable = "NON_CONSUMABLE"
				case nonRenewingSubscription = "NON_RENEWING_SUBSCRIPTION"
			}

			public enum FilterState: String, Codable, CaseIterable {
				case missingMetadata = "MISSING_METADATA"
				case waitingForUpload = "WAITING_FOR_UPLOAD"
				case processingContent = "PROCESSING_CONTENT"
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

			public enum Sort: String, Codable, CaseIterable {
				case inAppPurchaseType
				case minusinAppPurchaseType = "-inAppPurchaseType"
				case name
				case minusname = "-name"
			}

			public enum FieldsInAppPurchaseAppStoreReviewScreenshots: String, Codable, CaseIterable {
				case assetDeliveryState
				case assetToken
				case assetType
				case fileName
				case fileSize
				case imageAsset
				case inAppPurchaseV2
				case sourceFileChecksum
				case uploadOperations
				case uploaded
			}

			public enum FieldsInAppPurchasePricePoints: String, Codable, CaseIterable {
				case customerPrice
				case inAppPurchaseV2
				case priceTier
				case proceeds
				case territory
			}

			public enum FieldsPromotedPurchases: String, Codable, CaseIterable {
				case app
				case enabled
				case inAppPurchaseV2
				case promotionImages
				case state
				case subscription
				case visibleForAllUsers
			}

			public enum FieldsInAppPurchaseLocalizations: String, Codable, CaseIterable {
				case description
				case inAppPurchaseV2
				case locale
				case name
				case state
			}

			public enum FieldsInAppPurchases: String, Codable, CaseIterable {
				case app
				case appStoreReviewScreenshot
				case availableInAllTerritories
				case content
				case contentHosting
				case familySharable
				case iapPriceSchedule
				case inAppPurchaseLocalizations
				case inAppPurchaseType
				case name
				case pricePoints
				case productID = "productId"
				case promotedPurchase
				case reviewNote
				case state
			}

			public enum FieldsInAppPurchasePriceSchedules: String, Codable, CaseIterable {
				case inAppPurchase
				case manualPrices
			}

			public enum FieldsInAppPurchaseContents: String, Codable, CaseIterable {
				case fileName
				case fileSize
				case inAppPurchaseV2
				case lastModifiedDate
				case url
			}

			public enum Include: String, Codable, CaseIterable {
				case appStoreReviewScreenshot
				case content
				case iapPriceSchedule
				case inAppPurchaseLocalizations
				case pricePoints
				case promotedPurchase
			}

			public init(filterInAppPurchaseType: [FilterInAppPurchaseType]? = nil, filterName: [String]? = nil, filterProductID: [String]? = nil, filterState: [FilterState]? = nil, sort: [Sort]? = nil, fieldsInAppPurchaseAppStoreReviewScreenshots: [FieldsInAppPurchaseAppStoreReviewScreenshots]? = nil, fieldsInAppPurchasePricePoints: [FieldsInAppPurchasePricePoints]? = nil, fieldsPromotedPurchases: [FieldsPromotedPurchases]? = nil, fieldsInAppPurchaseLocalizations: [FieldsInAppPurchaseLocalizations]? = nil, fieldsInAppPurchases: [FieldsInAppPurchases]? = nil, fieldsInAppPurchasePriceSchedules: [FieldsInAppPurchasePriceSchedules]? = nil, fieldsInAppPurchaseContents: [FieldsInAppPurchaseContents]? = nil, limit: Int? = nil, limitInAppPurchaseLocalizations: Int? = nil, limitPricePoints: Int? = nil, include: [Include]? = nil) {
				self.filterInAppPurchaseType = filterInAppPurchaseType
				self.filterName = filterName
				self.filterProductID = filterProductID
				self.filterState = filterState
				self.sort = sort
				self.fieldsInAppPurchaseAppStoreReviewScreenshots = fieldsInAppPurchaseAppStoreReviewScreenshots
				self.fieldsInAppPurchasePricePoints = fieldsInAppPurchasePricePoints
				self.fieldsPromotedPurchases = fieldsPromotedPurchases
				self.fieldsInAppPurchaseLocalizations = fieldsInAppPurchaseLocalizations
				self.fieldsInAppPurchases = fieldsInAppPurchases
				self.fieldsInAppPurchasePriceSchedules = fieldsInAppPurchasePriceSchedules
				self.fieldsInAppPurchaseContents = fieldsInAppPurchaseContents
				self.limit = limit
				self.limitInAppPurchaseLocalizations = limitInAppPurchaseLocalizations
				self.limitPricePoints = limitPricePoints
				self.include = include
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(filterInAppPurchaseType, forKey: "filter[inAppPurchaseType]")
				encoder.encode(filterName, forKey: "filter[name]")
				encoder.encode(filterProductID, forKey: "filter[productId]")
				encoder.encode(filterState, forKey: "filter[state]")
				encoder.encode(sort, forKey: "sort")
				encoder.encode(fieldsInAppPurchaseAppStoreReviewScreenshots, forKey: "fields[inAppPurchaseAppStoreReviewScreenshots]")
				encoder.encode(fieldsInAppPurchasePricePoints, forKey: "fields[inAppPurchasePricePoints]")
				encoder.encode(fieldsPromotedPurchases, forKey: "fields[promotedPurchases]")
				encoder.encode(fieldsInAppPurchaseLocalizations, forKey: "fields[inAppPurchaseLocalizations]")
				encoder.encode(fieldsInAppPurchases, forKey: "fields[inAppPurchases]")
				encoder.encode(fieldsInAppPurchasePriceSchedules, forKey: "fields[inAppPurchasePriceSchedules]")
				encoder.encode(fieldsInAppPurchaseContents, forKey: "fields[inAppPurchaseContents]")
				encoder.encode(limit, forKey: "limit")
				encoder.encode(limitInAppPurchaseLocalizations, forKey: "limit[inAppPurchaseLocalizations]")
				encoder.encode(limitPricePoints, forKey: "limit[pricePoints]")
				encoder.encode(include, forKey: "include")
				return encoder.items
			}
		}
	}
}
