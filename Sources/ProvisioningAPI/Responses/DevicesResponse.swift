// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Shuttle

public struct DevicesResponse: Codable {
	public var data: [Device]
	public var links: PagedDocumentLinks
	public var meta: PagingInformation?

	public init(
        data: [Device],
        links: PagedDocumentLinks,
        meta: PagingInformation? = nil
    ) {
		self.data = data
		self.links = links
		self.meta = meta
	}
}