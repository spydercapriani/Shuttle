// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct ScmRepository: Codable, Identifiable {
	public var type: `Type`
	public var id: String
	public var attributes: Attributes?
	public var relationships: Relationships?
	public var links: ResourceLinks

	public enum `Type`: String, Codable, CaseIterable {
		case scmRepositories
	}

	public struct Attributes: Codable {
		public var lastAccessedDate: Date?
		public var httpCloneURL: URL?
		public var sshCloneURL: URL?
		public var ownerName: String?
		public var repositoryName: String?

		public init(lastAccessedDate: Date? = nil, httpCloneURL: URL? = nil, sshCloneURL: URL? = nil, ownerName: String? = nil, repositoryName: String? = nil) {
			self.lastAccessedDate = lastAccessedDate
			self.httpCloneURL = httpCloneURL
			self.sshCloneURL = sshCloneURL
			self.ownerName = ownerName
			self.repositoryName = repositoryName
		}

		private enum CodingKeys: String, CodingKey {
			case lastAccessedDate
			case httpCloneURL = "httpCloneUrl"
			case sshCloneURL = "sshCloneUrl"
			case ownerName
			case repositoryName
		}
	}

	public struct Relationships: Codable {
		public var scmProvider: ScmProvider?
		public var defaultBranch: DefaultBranch?

		public struct ScmProvider: Codable {
			public var links: Links?
			public var data: Data?

			public struct Links: Codable {
				public var this: String?
				public var related: String?

				public init(this: String? = nil, related: String? = nil) {
					self.this = this
					self.related = related
				}

				private enum CodingKeys: String, CodingKey {
					case this = "self"
					case related
				}
			}

			public struct Data: Codable, Identifiable {
				public var type: `Type`
				public var id: String

				public enum `Type`: String, Codable, CaseIterable {
					case scmProviders
				}

				public init(type: `Type`, id: String) {
					self.type = type
					self.id = id
				}
			}

			public init(links: Links? = nil, data: Data? = nil) {
				self.links = links
				self.data = data
			}
		}

		public struct DefaultBranch: Codable {
			public var links: Links?
			public var data: Data?

			public struct Links: Codable {
				public var this: String?
				public var related: String?

				public init(this: String? = nil, related: String? = nil) {
					self.this = this
					self.related = related
				}

				private enum CodingKeys: String, CodingKey {
					case this = "self"
					case related
				}
			}

			public struct Data: Codable, Identifiable {
				public var type: `Type`
				public var id: String

				public enum `Type`: String, Codable, CaseIterable {
					case scmGitReferences
				}

				public init(type: `Type`, id: String) {
					self.type = type
					self.id = id
				}
			}

			public init(links: Links? = nil, data: Data? = nil) {
				self.links = links
				self.data = data
			}
		}

		public init(scmProvider: ScmProvider? = nil, defaultBranch: DefaultBranch? = nil) {
			self.scmProvider = scmProvider
			self.defaultBranch = defaultBranch
		}
	}

	public init(type: `Type`, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks) {
		self.type = type
		self.id = id
		self.attributes = attributes
		self.relationships = relationships
		self.links = links
	}
}
