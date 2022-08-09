// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.BetaLicenseAgreements {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/betaLicenseAgreements/{id}`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<Shuttle.BetaLicenseAgreementResponse> {
			Request(method: "GET", url: path, query: parameters?.asQuery, id: "betaLicenseAgreements-get_instance")
		}

		public struct GetParameters {
			public var fieldsBetaLicenseAgreements: [FieldsBetaLicenseAgreements]?
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

			public init(fieldsBetaLicenseAgreements: [FieldsBetaLicenseAgreements]? = nil, include: [Include]? = nil, fieldsApps: [FieldsApps]? = nil) {
				self.fieldsBetaLicenseAgreements = fieldsBetaLicenseAgreements
				self.include = include
				self.fieldsApps = fieldsApps
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(fieldsBetaLicenseAgreements, forKey: "fields[betaLicenseAgreements]")
				encoder.encode(include, forKey: "include")
				encoder.encode(fieldsApps, forKey: "fields[apps]")
				return encoder.items
			}
		}

		public func patch(_ body: Shuttle.BetaLicenseAgreementUpdateRequest) -> Request<Shuttle.BetaLicenseAgreementResponse> {
			Request(method: "PATCH", url: path, body: body, id: "betaLicenseAgreements-update_instance")
		}
	}
}
