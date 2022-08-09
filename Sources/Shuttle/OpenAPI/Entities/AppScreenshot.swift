// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppScreenshot: Codable, Identifiable {
	public var type: `Type`
	public var id: String
	public var attributes: Attributes?
	public var relationships: Relationships?
	public var links: ResourceLinks

	public enum `Type`: String, Codable, CaseIterable {
		case appScreenshots
	}

	public struct Attributes: Codable {
		public var fileSize: Int?
		public var fileName: String?
		public var sourceFileChecksum: String?
		public var imageAsset: ImageAsset?
		public var assetToken: String?
		public var assetType: String?
		public var uploadOperations: [UploadOperation]?
		public var assetDeliveryState: AppMediaAssetState?

		public init(fileSize: Int? = nil, fileName: String? = nil, sourceFileChecksum: String? = nil, imageAsset: ImageAsset? = nil, assetToken: String? = nil, assetType: String? = nil, uploadOperations: [UploadOperation]? = nil, assetDeliveryState: AppMediaAssetState? = nil) {
			self.fileSize = fileSize
			self.fileName = fileName
			self.sourceFileChecksum = sourceFileChecksum
			self.imageAsset = imageAsset
			self.assetToken = assetToken
			self.assetType = assetType
			self.uploadOperations = uploadOperations
			self.assetDeliveryState = assetDeliveryState
		}
	}

	public struct Relationships: Codable {
		public var appScreenshotSet: AppScreenshotSet?

		public struct AppScreenshotSet: Codable {
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
					case appScreenshotSets
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

		public init(appScreenshotSet: AppScreenshotSet? = nil) {
			self.appScreenshotSet = appScreenshotSet
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
