// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppPreviewSetsResponse: Codable {
	public var data: [AppPreviewSet]
	public var included: [IncludedItem]?
	public var links: PagedDocumentLinks
	public var meta: PagingInformation?

	public enum IncludedItem: Codable {
		case appStoreVersionLocalization(AppStoreVersionLocalization)
		case appCustomProductPageLocalization(AppCustomProductPageLocalization)
		case appStoreVersionExperimentTreatmentLocalization(AppStoreVersionExperimentTreatmentLocalization)
		case appPreview(AppPreview)

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let value = try? container.decode(AppStoreVersionLocalization.self) {
				self = .appStoreVersionLocalization(value)
			} else if let value = try? container.decode(AppCustomProductPageLocalization.self) {
				self = .appCustomProductPageLocalization(value)
			} else if let value = try? container.decode(AppStoreVersionExperimentTreatmentLocalization.self) {
				self = .appStoreVersionExperimentTreatmentLocalization(value)
			} else if let value = try? container.decode(AppPreview.self) {
				self = .appPreview(value)
			} else {
				throw DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to intialize `oneOf`")
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .appStoreVersionLocalization(let value): try container.encode(value)
			case .appCustomProductPageLocalization(let value): try container.encode(value)
			case .appStoreVersionExperimentTreatmentLocalization(let value): try container.encode(value)
			case .appPreview(let value): try container.encode(value)
			}
		}
	}

	public init(data: [AppPreviewSet], included: [IncludedItem]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
		self.data = data
		self.included = included
		self.links = links
		self.meta = meta
	}
}
