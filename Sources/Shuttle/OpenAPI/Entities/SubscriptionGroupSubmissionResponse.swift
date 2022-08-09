// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct SubscriptionGroupSubmissionResponse: Codable {
	/// SubscriptionGroupSubmission
	public var data: SubscriptionGroupSubmission
	public var links: DocumentLinks

	public init(data: SubscriptionGroupSubmission, links: DocumentLinks) {
		self.data = data
		self.links = links
	}
}
