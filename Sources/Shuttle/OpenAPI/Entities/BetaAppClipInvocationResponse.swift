// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct BetaAppClipInvocationResponse: Codable {
	/// BetaAppClipInvocation
	public var data: BetaAppClipInvocation
	public var included: [BetaAppClipInvocationLocalization]?
	public var links: DocumentLinks

	public init(data: BetaAppClipInvocation, included: [BetaAppClipInvocationLocalization]? = nil, links: DocumentLinks) {
		self.data = data
		self.included = included
		self.links = links
	}
}