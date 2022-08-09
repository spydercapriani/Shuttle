// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppClipDefaultExperiencesResponse: Codable {
	public var data: [AppClipDefaultExperience]
	public var included: [IncludedItem]?
	public var links: PagedDocumentLinks
	public var meta: PagingInformation?

	public enum IncludedItem: Codable {
		case appClip(AppClip)
		case appStoreVersion(AppStoreVersion)
		case appClipDefaultExperienceLocalization(AppClipDefaultExperienceLocalization)
		case appClipAppStoreReviewDetail(AppClipAppStoreReviewDetail)

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let value = try? container.decode(AppClip.self) {
				self = .appClip(value)
			} else if let value = try? container.decode(AppStoreVersion.self) {
				self = .appStoreVersion(value)
			} else if let value = try? container.decode(AppClipDefaultExperienceLocalization.self) {
				self = .appClipDefaultExperienceLocalization(value)
			} else if let value = try? container.decode(AppClipAppStoreReviewDetail.self) {
				self = .appClipAppStoreReviewDetail(value)
			} else {
				throw DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to intialize `oneOf`")
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .appClip(let value): try container.encode(value)
			case .appStoreVersion(let value): try container.encode(value)
			case .appClipDefaultExperienceLocalization(let value): try container.encode(value)
			case .appClipAppStoreReviewDetail(let value): try container.encode(value)
			}
		}
	}

	public init(data: [AppClipDefaultExperience], included: [IncludedItem]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
		self.data = data
		self.included = included
		self.links = links
		self.meta = meta
	}
}
