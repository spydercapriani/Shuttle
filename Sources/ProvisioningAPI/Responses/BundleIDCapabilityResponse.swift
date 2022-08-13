// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Shuttle

public struct BundleIDCapabilityResponse: Codable {
	/// BundleIdCapability
	public var data: BundleIDCapability
	public var links: DocumentLinks

	public init(
        data: BundleIDCapability,
        links: DocumentLinks
    ) {
		self.data = data
		self.links = links
	}
}