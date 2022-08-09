// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var betaBuildLocalizations: BetaBuildLocalizations {
		BetaBuildLocalizations(path: path + "/betaBuildLocalizations")
	}

	public struct BetaBuildLocalizations {
		/// Path: `/v1/betaBuildLocalizations`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<Shuttle.BetaBuildLocalizationsResponse> {
			Request(method: "GET", url: path, query: parameters?.asQuery, id: "betaBuildLocalizations-get_collection")
		}

		public struct GetParameters {
			public var filterLocale: [String]?
			public var filterBuild: [String]?
			public var fieldsBetaBuildLocalizations: [FieldsBetaBuildLocalizations]?
			public var limit: Int?
			public var include: [Include]?
			public var fieldsBuilds: [FieldsBuilds]?

			public enum FieldsBetaBuildLocalizations: String, Codable, CaseIterable {
				case build
				case locale
				case whatsNew
			}

			public enum Include: String, Codable, CaseIterable {
				case build
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

			public init(filterLocale: [String]? = nil, filterBuild: [String]? = nil, fieldsBetaBuildLocalizations: [FieldsBetaBuildLocalizations]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsBuilds: [FieldsBuilds]? = nil) {
				self.filterLocale = filterLocale
				self.filterBuild = filterBuild
				self.fieldsBetaBuildLocalizations = fieldsBetaBuildLocalizations
				self.limit = limit
				self.include = include
				self.fieldsBuilds = fieldsBuilds
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(filterLocale, forKey: "filter[locale]")
				encoder.encode(filterBuild, forKey: "filter[build]")
				encoder.encode(fieldsBetaBuildLocalizations, forKey: "fields[betaBuildLocalizations]")
				encoder.encode(limit, forKey: "limit")
				encoder.encode(include, forKey: "include")
				encoder.encode(fieldsBuilds, forKey: "fields[builds]")
				return encoder.items
			}
		}

		public func post(_ body: Shuttle.BetaBuildLocalizationCreateRequest) -> Request<Shuttle.BetaBuildLocalizationResponse> {
			Request(method: "POST", url: path, body: body, id: "betaBuildLocalizations-create_instance")
		}
	}
}
