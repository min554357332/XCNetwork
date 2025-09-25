import Foundation

public protocol FireAdapter: Sendable {
    func adapt(_ request: Requestprotocol) async throws -> Requestprotocol
}

