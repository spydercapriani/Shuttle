// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct CiWorkflowResponse: Codable {
	/// CiWorkflow
	public var data: CiWorkflow
	public var included: [IncludedItem]?
	public var links: DocumentLinks

	public enum IncludedItem: Codable {
		case ciProduct(CiProduct)
		case scmRepository(ScmRepository)
		case ciXcodeVersion(CiXcodeVersion)
		case ciMacOsVersion(CiMacOsVersion)

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			if let value = try? container.decode(CiProduct.self) {
				self = .ciProduct(value)
			} else if let value = try? container.decode(ScmRepository.self) {
				self = .scmRepository(value)
			} else if let value = try? container.decode(CiXcodeVersion.self) {
				self = .ciXcodeVersion(value)
			} else if let value = try? container.decode(CiMacOsVersion.self) {
				self = .ciMacOsVersion(value)
			} else {
				throw DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to intialize `oneOf`")
			}
		}

		public func encode(to encoder: Encoder) throws {
			var container = encoder.singleValueContainer()
			switch self {
			case .ciProduct(let value): try container.encode(value)
			case .scmRepository(let value): try container.encode(value)
			case .ciXcodeVersion(let value): try container.encode(value)
			case .ciMacOsVersion(let value): try container.encode(value)
			}
		}
	}

	public init(data: CiWorkflow, included: [IncludedItem]? = nil, links: DocumentLinks) {
		self.data = data
		self.included = included
		self.links = links
	}
}
