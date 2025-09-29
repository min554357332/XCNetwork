import Foundation
import XCCache

public struct XCUser: Sendable, Codable, NECache {
    public var expiry: Double
    public var isVip: Bool {
        self.expiry > Date().timeIntervalSince1970
    }
    
    public init(expiry: Double) {
        self.expiry = expiry
    }
}
