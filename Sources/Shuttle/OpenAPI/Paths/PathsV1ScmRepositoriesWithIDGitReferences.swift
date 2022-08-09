// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.ScmRepositories.WithID {
	public var gitReferences: GitReferences {
		GitReferences(path: path + "/gitReferences")
	}

	public struct GitReferences {
		/// Path: `/v1/scmRepositories/{id}/gitReferences`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<Shuttle.ScmGitReferencesResponse> {
			Request(method: "GET", url: path, query: parameters?.asQuery, id: "scmRepositories-gitReferences-get_to_many_related")
		}

		public struct GetParameters {
			public var fieldsScmGitReferences: [FieldsScmGitReferences]?
			public var fieldsScmRepositories: [FieldsScmRepositories]?
			public var limit: Int?
			public var include: [Include]?

			public enum FieldsScmGitReferences: String, Codable, CaseIterable {
				case canonicalName
				case isDeleted
				case kind
				case name
				case repository
			}

			public enum FieldsScmRepositories: String, Codable, CaseIterable {
				case defaultBranch
				case gitReferences
				case httpCloneURL = "httpCloneUrl"
				case lastAccessedDate
				case ownerName
				case pullRequests
				case repositoryName
				case scmProvider
				case sshCloneURL = "sshCloneUrl"
			}

			public enum Include: String, Codable, CaseIterable {
				case repository
			}

			public init(fieldsScmGitReferences: [FieldsScmGitReferences]? = nil, fieldsScmRepositories: [FieldsScmRepositories]? = nil, limit: Int? = nil, include: [Include]? = nil) {
				self.fieldsScmGitReferences = fieldsScmGitReferences
				self.fieldsScmRepositories = fieldsScmRepositories
				self.limit = limit
				self.include = include
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(fieldsScmGitReferences, forKey: "fields[scmGitReferences]")
				encoder.encode(fieldsScmRepositories, forKey: "fields[scmRepositories]")
				encoder.encode(limit, forKey: "limit")
				encoder.encode(include, forKey: "include")
				return encoder.items
			}
		}
	}
}
