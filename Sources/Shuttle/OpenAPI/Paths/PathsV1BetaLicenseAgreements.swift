// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var betaLicenseAgreements: BetaLicenseAgreements {
		BetaLicenseAgreements(path: path + "/betaLicenseAgreements")
	}

	public struct BetaLicenseAgreements {
		/// Path: `/v1/betaLicenseAgreements`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<Shuttle.BetaLicenseAgreementsResponse> {
			Request(method: "GET", url: path, query: parameters?.asQuery, id: "betaLicenseAgreements-get_collection")
		}

		public struct GetParameters {
			public var filterApp: [String]?
			public var fieldsBetaLicenseAgreements: [FieldsBetaLicenseAgreements]?
			public var limit: Int?
			public var include: [Include]?
			public var fieldsApps: [FieldsApps]?

			public enum FieldsBetaLicenseAgreements: String, Codable, CaseIterable {
				case agreementText
				case app
			}

			public enum Include: String, Codable, CaseIterable {
				case app
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

			public init(filterApp: [String]? = nil, fieldsBetaLicenseAgreements: [FieldsBetaLicenseAgreements]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsApps: [FieldsApps]? = nil) {
				self.filterApp = filterApp
				self.fieldsBetaLicenseAgreements = fieldsBetaLicenseAgreements
				self.limit = limit
				self.include = include
				self.fieldsApps = fieldsApps
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(filterApp, forKey: "filter[app]")
				encoder.encode(fieldsBetaLicenseAgreements, forKey: "fields[betaLicenseAgreements]")
				encoder.encode(limit, forKey: "limit")
				encoder.encode(include, forKey: "include")
				encoder.encode(fieldsApps, forKey: "fields[apps]")
				return encoder.items
			}
		}
	}
}
