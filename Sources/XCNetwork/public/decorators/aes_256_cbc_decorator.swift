import Foundation
import AES_256_CBC

public struct Aes256cbc_decorator: Sendable {
    private let key: String
    private let iv: String
    
    public init(
        key: String,
        iv: String
    ) async throws {
        self.key = key
        self.iv = iv
        self.key_data = try await key.toData_async(-1000)
        self.iv_data = try await iv.toData_async(-2000)
    }
    
    public let key_data: Data
    public let iv_data: Data
}

