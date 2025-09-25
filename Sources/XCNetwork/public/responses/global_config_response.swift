import Foundation
import XCCache

public struct Global_config_response: Sendable, Codable, NECache {
    public var import_country: [String]?
    public var test_urls: [String]?
    public var success_rate: Double?
}
