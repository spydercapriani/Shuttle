// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct ResourceLinks: Codable {
	public var this: String

	public init(this: String) {
		self.this = this
	}

	private enum CodingKeys: String, CodingKey {
		case this = "self"
	}
}
