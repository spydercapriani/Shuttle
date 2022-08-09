// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct GameCenterEnabledVersionsResponse: Codable {
	public var data: [GameCenterEnabledVersion]
	public var included: [IncludedItem]?
	public var links: PagedDocumentLinks
	public var meta: PagingInformation?

	public enum IncludedItem: Codable {
		case gameCenterEnabledVersion(GameCenterEnabledVersion)
		case app(App)

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let value = try? container.decode(GameCenterEnabledVersion.self) {
				self = .gameCenterEnabledVersion(value)
			} else if let value = try? container.decode(App.self) {
				self = .app(value)
			} else {
				throw DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to intialize `oneOf`")
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .gameCenterEnabledVersion(let value): try container.encode(value)
			case .app(let value): try container.encode(value)
			}
		}
	}

	public init(data: [GameCenterEnabledVersion], included: [IncludedItem]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
		self.data = data
		self.included = included
		self.links = links
		self.meta = meta
	}
}