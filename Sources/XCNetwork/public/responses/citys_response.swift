import Foundation
import XCCache

public struct Citys_response: Sendable, Codable, NECache {
    public var id: Int
    public var country: String
    public var country_name: String
    public var city: String
    public var flag: String
    public var test_url: String
    public var premium: Bool
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
