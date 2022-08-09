// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.AppClipAdvancedExperienceImages {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/appClipAdvancedExperienceImages/{id}`
		public let path: String

		public func get(fieldsAppClipAdvancedExperienceImages: [FieldsAppClipAdvancedExperienceImages]? = nil) -> Request<Shuttle.AppClipAdvancedExperienceImageResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsAppClipAdvancedExperienceImages), id: "appClipAdvancedExperienceImages-get_instance")
		}

		private func makeGetQuery(_ fieldsAppClipAdvancedExperienceImages: [FieldsAppClipAdvancedExperienceImages]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsAppClipAdvancedExperienceImages, forKey: "fields[appClipAdvancedExperienceImages]", explode: false)
			return encoder.items
		}

		public enum FieldsAppClipAdvancedExperienceImages: String, Codable, CaseIterable {
			case assetDeliveryState
			case fileName
			case fileSize
			case imageAsset
			case sourceFileChecksum
			case uploadOperations
			case uploaded
		}

		public func patch(_ body: Shuttle.AppClipAdvancedExperienceImageUpdateRequest) -> Request<Shuttle.AppClipAdvancedExperienceImageResponse> {
			Request(method: "PATCH", url: path, body: body, id: "appClipAdvancedExperienceImages-update_instance")
		}
	}
}