// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct ErrorResponse: Codable {
	public var errors: [Error]?

	public struct Error: Codable, Identifiable {
		public var id: String?
		public var status: String
		public var code: String
		public var title: String
		public var detail: String
		public var source: Source?

		public enum Source: Codable {
			case errorSourcePointer(ErrorSourcePointer)
			case errorSourceParameter(ErrorSourceParameter)

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				if let value = try? container.decode(ErrorSourcePointer.self) {
					self = .errorSourcePointer(value)
				} else if let value = try? container.decode(ErrorSourceParameter.self) {
					self = .errorSourceParameter(value)
				} else {
					throw DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to intialize `oneOf`")
				}
			}

			public func encode(to encoder: Encoder) throws {
				var container = encoder.singleValueContainer()
				switch self {
				case .errorSourcePointer(let value): try container.encode(value)
				case .errorSourceParameter(let value): try container.encode(value)
				}
			}
		}

		public init(id: String? = nil, status: String, code: String, title: String, detail: String, source: Source? = nil) {
			self.id = id
			self.status = status
			self.code = code
			self.title = title
			self.detail = detail
			self.source = source
		}
	}

	public init(errors: [Error]? = nil) {
		self.errors = errors
	}
}