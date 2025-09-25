import Foundation
import XCCache

public struct Host_response: Sendable, Codable, NECache {
    public let config_host: String
    public let ad_host: String
}
