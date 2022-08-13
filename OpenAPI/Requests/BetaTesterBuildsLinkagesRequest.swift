// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct BetaTesterBuildsLinkagesRequest: Codable {
	public var data: [Datum]

	public struct Datum: Codable, Identifiable {
		public var type: `Type`
		public var id: String

		public enum `Type`: String, Codable, CaseIterable {
			case builds
		}

		public init(type: `Type`, id: String) {
			self.type = type
			self.id = id
		}
	}

	public init(data: [Datum]) {
		self.data = data
	}
}