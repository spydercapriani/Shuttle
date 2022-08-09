// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct InAppPurchasePricePointsResponse: Codable {
	public var data: [InAppPurchasePricePoint]
	public var included: [Territory]?
	public var links: PagedDocumentLinks
	public var meta: PagingInformation?

	public init(data: [InAppPurchasePricePoint], included: [Territory]? = nil, links: PagedDocumentLinks, meta: PagingInformation? = nil) {
		self.data = data
		self.included = included
		self.links = links
		self.meta = meta
	}
}
