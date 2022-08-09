// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppMediaAssetState: Codable {
	public var errors: [AppMediaStateError]?
	public var warnings: [AppMediaStateError]?
	public var state: State?

	public enum State: String, Codable, CaseIterable {
		case awaitingUpload = "AWAITING_UPLOAD"
		case uploadComplete = "UPLOAD_COMPLETE"
		case complete = "COMPLETE"
		case failed = "FAILED"
	}

	public init(errors: [AppMediaStateError]? = nil, warnings: [AppMediaStateError]? = nil, state: State? = nil) {
		self.errors = errors
		self.warnings = warnings
		self.state = state
	}
}
