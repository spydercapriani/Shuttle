// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppPreOrderResponse: Codable {
	/// AppPreOrder
	public var data: AppPreOrder
	public var included: [App]?
	public var links: DocumentLinks

	public init(data: AppPreOrder, included: [App]? = nil, links: DocumentLinks) {
		self.data = data
		self.included = included
		self.links = links
	}
}
