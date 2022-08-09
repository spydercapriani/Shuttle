// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.Builds.WithID {
	public var buildBetaDetail: BuildBetaDetail {
		BuildBetaDetail(path: path + "/buildBetaDetail")
	}

	public struct BuildBetaDetail {
		/// Path: `/v1/builds/{id}/buildBetaDetail`
		public let path: String

		public func get(fieldsBuildBetaDetails: [FieldsBuildBetaDetails]? = nil) -> Request<Shuttle.BuildBetaDetailResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsBuildBetaDetails), id: "builds-buildBetaDetail-get_to_one_related")
		}

		private func makeGetQuery(_ fieldsBuildBetaDetails: [FieldsBuildBetaDetails]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsBuildBetaDetails, forKey: "fields[buildBetaDetails]", explode: false)
			return encoder.items
		}

		public enum FieldsBuildBetaDetails: String, Codable, CaseIterable {
			case autoNotifyEnabled
			case build
			case externalBuildState
			case internalBuildState
		}
	}
}
