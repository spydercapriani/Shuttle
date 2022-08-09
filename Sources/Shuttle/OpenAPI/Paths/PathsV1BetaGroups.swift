// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var betaGroups: BetaGroups {
		BetaGroups(path: path + "/betaGroups")
	}

	public struct BetaGroups {
		/// Path: `/v1/betaGroups`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<Shuttle.BetaGroupsResponse> {
			Request(method: "GET", url: path, query: parameters?.asQuery, id: "betaGroups-get_collection")
		}

		public struct GetParameters {
			public var filterIsInternalGroup: [String]?
			public var filterName: [String]?
			public var filterPublicLink: [String]?
			public var filterPublicLinkEnabled: [String]?
			public var filterPublicLinkLimitEnabled: [String]?
			public var filterApp: [String]?
			public var filterBuilds: [String]?
			public var filterID: [String]?
			public var sort: [Sort]?
			public var fieldsBetaGroups: [FieldsBetaGroups]?
			public var limit: Int?
			public var include: [Include]?
			public var fieldsBetaTesters: [FieldsBetaTesters]?
			public var fieldsApps: [FieldsApps]?
			public var fieldsBuilds: [FieldsBuilds]?
			public var limitBetaTesters: Int?
			public var limitBuilds: Int?

			public enum Sort: String, Codable, CaseIterable {
				case createdDate
				case minuscreatedDate = "-createdDate"
				case name
				case minusname = "-name"
				case publicLinkEnabled
				case minuspublicLinkEnabled = "-publicLinkEnabled"
				case publicLinkLimit
				case minuspublicLinkLimit = "-publicLinkLimit"
			}

			public enum FieldsBetaGroups: String, Codable, CaseIterable {
				case app
				case betaTesters
				case builds
				case createdDate
				case feedbackEnabled
				case hasAccessToAllBuilds
				case iosBuildsAvailableForAppleSiliconMac
				case isInternalGroup
				case name
				case publicLink
				case publicLinkEnabled
				case publicLinkID = "publicLinkId"
				case publicLinkLimit
				case publicLinkLimitEnabled
			}

			public enum Include: String, Codable, CaseIterable {
				case app
				case betaTesters
				case builds
			}

			public enum FieldsBetaTesters: String, Codable, CaseIterable {
				case apps
				case betaGroups
				case builds
				case email
				case firstName
				case inviteType
				case lastName
			}

			public enum FieldsApps: String, Codable, CaseIterable {
				case appClips
				case appCustomProductPages
				case appEvents
				case appInfos
				case appStoreVersions
				case availableInNewTerritories
				case availableTerritories
				case betaAppLocalizations
				case betaAppReviewDetail
				case betaGroups
				case betaLicenseAgreement
				case betaTesters
				case builds
				case bundleID = "bundleId"
				case ciProduct
				case contentRightsDeclaration
				case customerReviews
				case endUserLicenseAgreement
				case gameCenterEnabledVersions
				case inAppPurchases
				case inAppPurchasesV2
				case isOrEverWasMadeForKids
				case name
				case perfPowerMetrics
				case preOrder
				case preReleaseVersions
				case pricePoints
				case prices
				case primaryLocale
				case promotedPurchases
				case reviewSubmissions
				case sku
				case subscriptionGracePeriod
				case subscriptionGroups
				case subscriptionStatusURL = "subscriptionStatusUrl"
				case subscriptionStatusURLForSandbox = "subscriptionStatusUrlForSandbox"
				case subscriptionStatusURLVersion = "subscriptionStatusUrlVersion"
				case subscriptionStatusURLVersionForSandbox = "subscriptionStatusUrlVersionForSandbox"
			}

			public enum FieldsBuilds: String, Codable, CaseIterable {
				case app
				case appEncryptionDeclaration
				case appStoreVersion
				case betaAppReviewSubmission
				case betaBuildLocalizations
				case betaGroups
				case buildAudienceType
				case buildBetaDetail
				case buildBundles
				case computedMinMacOsVersion
				case diagnosticSignatures
				case expirationDate
				case expired
				case iconAssetToken
				case icons
				case individualTesters
				case lsMinimumSystemVersion
				case minOsVersion
				case perfPowerMetrics
				case preReleaseVersion
				case processingState
				case uploadedDate
				case usesNonExemptEncryption
				case version
			}

			public init(filterIsInternalGroup: [String]? = nil, filterName: [String]? = nil, filterPublicLink: [String]? = nil, filterPublicLinkEnabled: [String]? = nil, filterPublicLinkLimitEnabled: [String]? = nil, filterApp: [String]? = nil, filterBuilds: [String]? = nil, filterID: [String]? = nil, sort: [Sort]? = nil, fieldsBetaGroups: [FieldsBetaGroups]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsBetaTesters: [FieldsBetaTesters]? = nil, fieldsApps: [FieldsApps]? = nil, fieldsBuilds: [FieldsBuilds]? = nil, limitBetaTesters: Int? = nil, limitBuilds: Int? = nil) {
				self.filterIsInternalGroup = filterIsInternalGroup
				self.filterName = filterName
				self.filterPublicLink = filterPublicLink
				self.filterPublicLinkEnabled = filterPublicLinkEnabled
				self.filterPublicLinkLimitEnabled = filterPublicLinkLimitEnabled
				self.filterApp = filterApp
				self.filterBuilds = filterBuilds
				self.filterID = filterID
				self.sort = sort
				self.fieldsBetaGroups = fieldsBetaGroups
				self.limit = limit
				self.include = include
				self.fieldsBetaTesters = fieldsBetaTesters
				self.fieldsApps = fieldsApps
				self.fieldsBuilds = fieldsBuilds
				self.limitBetaTesters = limitBetaTesters
				self.limitBuilds = limitBuilds
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(filterIsInternalGroup, forKey: "filter[isInternalGroup]")
				encoder.encode(filterName, forKey: "filter[name]")
				encoder.encode(filterPublicLink, forKey: "filter[publicLink]")
				encoder.encode(filterPublicLinkEnabled, forKey: "filter[publicLinkEnabled]")
				encoder.encode(filterPublicLinkLimitEnabled, forKey: "filter[publicLinkLimitEnabled]")
				encoder.encode(filterApp, forKey: "filter[app]")
				encoder.encode(filterBuilds, forKey: "filter[builds]")
				encoder.encode(filterID, forKey: "filter[id]")
				encoder.encode(sort, forKey: "sort")
				encoder.encode(fieldsBetaGroups, forKey: "fields[betaGroups]")
				encoder.encode(limit, forKey: "limit")
				encoder.encode(include, forKey: "include")
				encoder.encode(fieldsBetaTesters, forKey: "fields[betaTesters]")
				encoder.encode(fieldsApps, forKey: "fields[apps]")
				encoder.encode(fieldsBuilds, forKey: "fields[builds]")
				encoder.encode(limitBetaTesters, forKey: "limit[betaTesters]")
				encoder.encode(limitBuilds, forKey: "limit[builds]")
				return encoder.items
			}
		}

		public func post(_ body: Shuttle.BetaGroupCreateRequest) -> Request<Shuttle.BetaGroupResponse> {
			Request(method: "POST", url: path, body: body, id: "betaGroups-create_instance")
		}
	}
}
