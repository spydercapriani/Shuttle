// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct CertificateResponse: Codable {
	/// Certificate
	public var data: Certificate
	public var links: DocumentLinks

	public init(data: Certificate, links: DocumentLinks) {
		self.data = data
		self.links = links
	}
}
