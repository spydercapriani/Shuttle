// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct BetaTesterBetaGroupsLinkagesResponse: Codable {
	public var data: [Datum]
	public var links: PagedDocumentLinks
	public var meta: PagingInformation?

	public struct Datum: Codable, Identifiable {
		public var type: `Type`
		public var id: String

		public enum `Type`: String, Codable, CaseIterable {
			case betaGroups
		}

		public init(type: `Type`, id: String) {
			self.type = type
			self.id = id
		}
	}

	public init(data: [Datum], links: PagedDocumentLinks, meta: PagingInformation? = nil) {
		self.data = data
		self.links = links
		self.meta = meta
	}
}
