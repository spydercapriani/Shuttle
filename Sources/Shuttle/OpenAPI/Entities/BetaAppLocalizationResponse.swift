// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct BetaAppLocalizationResponse: Codable {
	/// BetaAppLocalization
	public var data: BetaAppLocalization
	public var included: [App]?
	public var links: DocumentLinks

	public init(data: BetaAppLocalization, included: [App]? = nil, links: DocumentLinks) {
		self.data = data
		self.included = included
		self.links = links
	}
}