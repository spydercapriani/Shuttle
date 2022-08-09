// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct BuildAppEncryptionDeclarationLinkageRequest: Codable {
	public var data: Data

	public struct Data: Codable, Identifiable {
		public var type: `Type`
		public var id: String

		public enum `Type`: String, Codable, CaseIterable {
			case appEncryptionDeclarations
		}

		public init(type: `Type`, id: String) {
			self.type = type
			self.id = id
		}
	}

	public init(data: Data) {
		self.data = data
	}
}
