// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var betaAppReviewSubmissions: BetaAppReviewSubmissions {
		BetaAppReviewSubmissions(path: path + "/betaAppReviewSubmissions")
	}

	public struct BetaAppReviewSubmissions {
		/// Path: `/v1/betaAppReviewSubmissions`
		public let path: String

		public func get(parameters: GetParameters) -> Request<Shuttle.BetaAppReviewSubmissionsResponse> {
			Request(method: "GET", url: path, query: parameters.asQuery, id: "betaAppReviewSubmissions-get_collection")
		}

		public struct GetParameters {
			public var filterBetaReviewState: [FilterBetaReviewState]?
			public var filterBuild: [String]
			public var fieldsBetaAppReviewSubmissions: [FieldsBetaAppReviewSubmissions]?
			public var limit: Int?
			public var include: [Include]?
			public var fieldsBuilds: [FieldsBuilds]?

			public enum FilterBetaReviewState: String, Codable, CaseIterable {
				case waitingForReview = "WAITING_FOR_REVIEW"
				case inReview = "IN_REVIEW"
				case rejected = "REJECTED"
				case approved = "APPROVED"
			}

			public enum FieldsBetaAppReviewSubmissions: String, Codable, CaseIterable {
				case betaReviewState
				case build
				case submittedDate
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

			public init(filterBetaReviewState: [FilterBetaReviewState]? = nil, filterBuild: [String], fieldsBetaAppReviewSubmissions: [FieldsBetaAppReviewSubmissions]? = nil, limit: Int? = nil, include: [Include]? = nil, fieldsBuilds: [FieldsBuilds]? = nil) {
				self.filterBetaReviewState = filterBetaReviewState
				self.filterBuild = filterBuild
				self.fieldsBetaAppReviewSubmissions = fieldsBetaAppReviewSubmissions
				self.limit = limit
				self.include = include
				self.fieldsBuilds = fieldsBuilds
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(filterBetaReviewState, forKey: "filter[betaReviewState]")
				encoder.encode(filterBuild, forKey: "filter[build]")
				encoder.encode(fieldsBetaAppReviewSubmissions, forKey: "fields[betaAppReviewSubmissions]")
				encoder.encode(limit, forKey: "limit")
				encoder.encode(include, forKey: "include")
				encoder.encode(fieldsBuilds, forKey: "fields[builds]")
				return encoder.items
			}
		}

		public func post(_ body: Shuttle.BetaAppReviewSubmissionCreateRequest) -> Request<Shuttle.BetaAppReviewSubmissionResponse> {
			Request(method: "POST", url: path, body: body, id: "betaAppReviewSubmissions-create_instance")
		}
	}
}
