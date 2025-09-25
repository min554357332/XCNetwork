import Foundation
import XCCache

public struct Base_response<D: Codable & Sendable>: Codable, Sendable, NECache {
    public var code: Int
    public var message: String
    public var data: D?
}
