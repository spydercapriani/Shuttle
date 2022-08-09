// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.CiMacOsVersions {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/ciMacOsVersions/{id}`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<Shuttle.CiMacOsVersionResponse> {
			Request(method: "GET", url: path, query: parameters?.asQuery, id: "ciMacOsVersions-get_instance")
		}

		public struct GetParameters {
			public var fieldsCiMacOsVersions: [FieldsCiMacOsVersions]?
			public var include: [Include]?
			public var fieldsCiXcodeVersions: [FieldsCiXcodeVersions]?
			public var limitXcodeVersions: Int?

			public enum FieldsCiMacOsVersions: String, Codable, CaseIterable {
				case name
				case version
				case xcodeVersions
			}

			public enum Include: String, Codable, CaseIterable {
				case xcodeVersions
			}

			public enum FieldsCiXcodeVersions: String, Codable, CaseIterable {
				case macOsVersions
				case name
				case testDestinations
				case version
			}

			public init(fieldsCiMacOsVersions: [FieldsCiMacOsVersions]? = nil, include: [Include]? = nil, fieldsCiXcodeVersions: [FieldsCiXcodeVersions]? = nil, limitXcodeVersions: Int? = nil) {
				self.fieldsCiMacOsVersions = fieldsCiMacOsVersions
				self.include = include
				self.fieldsCiXcodeVersions = fieldsCiXcodeVersions
				self.limitXcodeVersions = limitXcodeVersions
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(fieldsCiMacOsVersions, forKey: "fields[ciMacOsVersions]")
				encoder.encode(include, forKey: "include")
				encoder.encode(fieldsCiXcodeVersions, forKey: "fields[ciXcodeVersions]")
				encoder.encode(limitXcodeVersions, forKey: "limit[xcodeVersions]")
				return encoder.items
			}
		}
	}
}
