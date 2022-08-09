// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.BetaAppReviewSubmissions.WithID {
	public var build: Build {
		Build(path: path + "/build")
	}

	public struct Build {
		/// Path: `/v1/betaAppReviewSubmissions/{id}/build`
		public let path: String

		public func get(fieldsBuilds: [FieldsBuilds]? = nil) -> Request<Shuttle.BuildResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsBuilds), id: "betaAppReviewSubmissions-build-get_to_one_related")
		}

		private func makeGetQuery(_ fieldsBuilds: [FieldsBuilds]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsBuilds, forKey: "fields[builds]", explode: false)
			return encoder.items
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
	}
}
