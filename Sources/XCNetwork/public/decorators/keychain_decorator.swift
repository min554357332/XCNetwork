import Foundation
import AES_256_CBC

public struct KeyChain_decorator: Sendable {
    private let key_uuid: String
    
    public init(key_uuid: String) async throws {
        self.key_uuid = key_uuid
        self.decrypt_key_uuid = try await AES256CBC.de_string_async(key_uuid, -10000)
    }
    
    public let decrypt_key_uuid: String
}
