// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Shuttle

public struct ProfilesResponse: Codable {
	public var data: [Profile]
	public var included: [IncludedItem]?
	public var links: PagedDocumentLinks
	public var meta: PagingInformation?

	public enum IncludedItem: Codable {
		case bundleID(BundleID)
		case device(Device)
		case certificate(Certificate)

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let value = try? container.decode(BundleID.self) {
				self = .bundleID(value)
			} else if let value = try? container.decode(Device.self) {
				self = .device(value)
			} else if let value = try? container.decode(Certificate.self) {
				self = .certificate(value)
			} else {
				throw DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to intialize `oneOf`")
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .bundleID(let value): try container.encode(value)
			case .device(let value): try container.encode(value)
			case .certificate(let value): try container.encode(value)
			}
		}
	}

	public init(
        data: [Profile],
        included: [IncludedItem]? = nil,
        links: PagedDocumentLinks,
        meta: PagingInformation? = nil
    ) {
		self.data = data
		self.included = included
		self.links = links
		self.meta = meta
	}
}

// MARK: - LargeDataSet
extension ProfilesResponse: LargeDataSet { }
