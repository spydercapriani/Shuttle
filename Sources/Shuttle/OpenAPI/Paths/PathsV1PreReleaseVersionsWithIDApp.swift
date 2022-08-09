// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.PreReleaseVersions.WithID {
	public var app: App {
		App(path: path + "/app")
	}

	public struct App {
		/// Path: `/v1/preReleaseVersions/{id}/app`
		public let path: String

		public func get(fieldsApps: [FieldsApps]? = nil) -> Request<Shuttle.AppResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsApps), id: "preReleaseVersions-app-get_to_one_related")
		}

		private func makeGetQuery(_ fieldsApps: [FieldsApps]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsApps, forKey: "fields[apps]", explode: false)
			return encoder.items
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
	}
}
