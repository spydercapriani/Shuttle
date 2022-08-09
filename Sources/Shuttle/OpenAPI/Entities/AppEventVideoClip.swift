// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppEventVideoClip: Codable, Identifiable {
	public var type: `Type`
	public var id: String
	public var attributes: Attributes?
	public var relationships: Relationships?
	public var links: ResourceLinks

	public enum `Type`: String, Codable, CaseIterable {
		case appEventVideoClips
	}

	public struct Attributes: Codable {
		public var fileSize: Int?
		public var fileName: String?
		public var previewFrameTimeCode: String?
		public var videoURL: String?
		public var previewImage: ImageAsset?
		public var uploadOperations: [UploadOperation]?
		public var assetDeliveryState: AppMediaAssetState?
		public var appEventAssetType: AppEventAssetType?

		public init(fileSize: Int? = nil, fileName: String? = nil, previewFrameTimeCode: String? = nil, videoURL: String? = nil, previewImage: ImageAsset? = nil, uploadOperations: [UploadOperation]? = nil, assetDeliveryState: AppMediaAssetState? = nil, appEventAssetType: AppEventAssetType? = nil) {
			self.fileSize = fileSize
			self.fileName = fileName
			self.previewFrameTimeCode = previewFrameTimeCode
			self.videoURL = videoURL
			self.previewImage = previewImage
			self.uploadOperations = uploadOperations
			self.assetDeliveryState = assetDeliveryState
			self.appEventAssetType = appEventAssetType
		}

		private enum CodingKeys: String, CodingKey {
			case fileSize
			case fileName
			case previewFrameTimeCode
			case videoURL = "videoUrl"
			case previewImage
			case uploadOperations
			case assetDeliveryState
			case appEventAssetType
		}
	}

	public struct Relationships: Codable {
		public var appEventLocalization: AppEventLocalization?

		public struct AppEventLocalization: Codable {
			public var links: Links?
			public var data: Data?

			public struct Links: Codable {
				public var this: String?
				public var related: String?

				public init(this: String? = nil, related: String? = nil) {
					self.this = this
					self.related = related
				}

				private enum CodingKeys: String, CodingKey {
					case this = "self"
					case related
				}
			}

			public struct Data: Codable, Identifiable {
				public var type: `Type`
				public var id: String

				public enum `Type`: String, Codable, CaseIterable {
					case appEventLocalizations
				}

				public init(type: `Type`, id: String) {
					self.type = type
					self.id = id
				}
			}

			public init(links: Links? = nil, data: Data? = nil) {
				self.links = links
				self.data = data
			}
		}

		public init(appEventLocalization: AppEventLocalization? = nil) {
			self.appEventLocalization = appEventLocalization
		}
	}

	public init(type: `Type`, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks) {
		self.type = type
		self.id = id
		self.attributes = attributes
		self.relationships = relationships
		self.links = links
	}
}
