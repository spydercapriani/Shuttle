// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct BuildBetaNotification: Codable, Identifiable {
	public var type: `Type`
	public var id: String
	public var links: ResourceLinks

	public enum `Type`: String, Codable, CaseIterable {
		case buildBetaNotifications
	}

	public init(type: `Type`, id: String, links: ResourceLinks) {
		self.type = type
		self.id = id
		self.links = links
	}
}
