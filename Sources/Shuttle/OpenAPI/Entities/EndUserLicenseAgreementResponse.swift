// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct EndUserLicenseAgreementResponse: Codable {
	/// EndUserLicenseAgreement
	public var data: EndUserLicenseAgreement
	public var included: [IncludedItem]?
	public var links: DocumentLinks

	public enum IncludedItem: Codable {
		case app(App)
		case territory(Territory)

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let value = try? container.decode(App.self) {
				self = .app(value)
			} else if let value = try? container.decode(Territory.self) {
				self = .territory(value)
			} else {
				throw DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to intialize `oneOf`")
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .app(let value): try container.encode(value)
			case .territory(let value): try container.encode(value)
			}
		}
	}

	public init(data: EndUserLicenseAgreement, included: [IncludedItem]? = nil, links: DocumentLinks) {
		self.data = data
		self.included = included
		self.links = links
	}
}
