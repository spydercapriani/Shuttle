// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct SubscriptionLocalizationsResponse: Codable {
	public var data: [SubscriptionLocalization]
	public var included: [Subscription]?
	public var links: PagedDocumentLinks
	public var meta: PagingInformation?

	public init(data: [SubscriptionLocalization], included: [Subscription]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
		self.data = data
		self.included = included
		self.links = links
		self.meta = meta
	}
}
