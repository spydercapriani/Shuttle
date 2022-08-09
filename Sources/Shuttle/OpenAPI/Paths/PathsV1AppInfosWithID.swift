// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.AppInfos {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/appInfos/{id}`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<Shuttle.AppInfoResponse> {
			Request(method: "GET", url: path, query: parameters?.asQuery, id: "appInfos-get_instance")
		}

		public struct GetParameters {
			public var fieldsAppInfos: [FieldsAppInfos]?
			public var include: [Include]?
			public var fieldsAgeRatingDeclarations: [FieldsAgeRatingDeclarations]?
			public var fieldsAppInfoLocalizations: [FieldsAppInfoLocalizations]?
			public var fieldsAppCategories: [FieldsAppCategories]?
			public var limitAppInfoLocalizations: Int?

			public enum FieldsAppInfos: String, Codable, CaseIterable {
				case ageRatingDeclaration
				case app
				case appInfoLocalizations
				case appStoreAgeRating
				case appStoreState
				case brazilAgeRating
				case kidsAgeBand
				case primaryCategory
				case primarySubcategoryOne
				case primarySubcategoryTwo
				case secondaryCategory
				case secondarySubcategoryOne
				case secondarySubcategoryTwo
			}

			public enum Include: String, Codable, CaseIterable {
				case ageRatingDeclaration
				case app
				case appInfoLocalizations
				case primaryCategory
				case primarySubcategoryOne
				case primarySubcategoryTwo
				case secondaryCategory
				case secondarySubcategoryOne
				case secondarySubcategoryTwo
			}

			public enum FieldsAgeRatingDeclarations: String, Codable, CaseIterable {
				case alcoholTobaccoOrDrugUseOrReferences
				case contests
				case gambling
				case gamblingAndContests
				case gamblingSimulated
				case horrorOrFearThemes
				case kidsAgeBand
				case matureOrSuggestiveThemes
				case medicalOrTreatmentInformation
				case profanityOrCrudeHumor
				case seventeenPlus
				case sexualContentGraphicAndNudity
				case sexualContentOrNudity
				case unrestrictedWebAccess
				case violenceCartoonOrFantasy
				case violenceRealistic
				case violenceRealisticProlongedGraphicOrSadistic
			}

			public enum FieldsAppInfoLocalizations: String, Codable, CaseIterable {
				case appInfo
				case locale
				case name
				case privacyChoicesURL = "privacyChoicesUrl"
				case privacyPolicyText
				case privacyPolicyURL = "privacyPolicyUrl"
				case subtitle
			}

			public enum FieldsAppCategories: String, Codable, CaseIterable {
				case parent
				case platforms
				case subcategories
			}

			public init(fieldsAppInfos: [FieldsAppInfos]? = nil, include: [Include]? = nil, fieldsAgeRatingDeclarations: [FieldsAgeRatingDeclarations]? = nil, fieldsAppInfoLocalizations: [FieldsAppInfoLocalizations]? = nil, fieldsAppCategories: [FieldsAppCategories]? = nil, limitAppInfoLocalizations: Int? = nil) {
				self.fieldsAppInfos = fieldsAppInfos
				self.include = include
				self.fieldsAgeRatingDeclarations = fieldsAgeRatingDeclarations
				self.fieldsAppInfoLocalizations = fieldsAppInfoLocalizations
				self.fieldsAppCategories = fieldsAppCategories
				self.limitAppInfoLocalizations = limitAppInfoLocalizations
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(fieldsAppInfos, forKey: "fields[appInfos]")
				encoder.encode(include, forKey: "include")
				encoder.encode(fieldsAgeRatingDeclarations, forKey: "fields[ageRatingDeclarations]")
				encoder.encode(fieldsAppInfoLocalizations, forKey: "fields[appInfoLocalizations]")
				encoder.encode(fieldsAppCategories, forKey: "fields[appCategories]")
				encoder.encode(limitAppInfoLocalizations, forKey: "limit[appInfoLocalizations]")
				return encoder.items
			}
		}

		public func patch(_ body: Shuttle.AppInfoUpdateRequest) -> Request<Shuttle.AppInfoResponse> {
			Request(method: "PATCH", url: path, body: body, id: "appInfos-update_instance")
		}
	}
}
