import Foundation
import AES_256_CBC
import CacheDataPreprocessor

public struct CacheDecryptDataPreprocessor: Sendable, XCCacheDataPreprocessor {
    
    let key: Data
    let iv: Data
    
    init() async {
        let decorator = await XCNetwork.share.en_de_decorator!
        self.key = decorator.key_data
        self.iv = decorator.iv_data
    }
    
    public func preprocess(data: Data) async throws -> Data {
        return try await AES256CBC.decrypt_async(data: data, key: self.key, iv: self.iv)
    }
    
}

public struct CacheEncryptDataPreprocessor: Sendable, XCCacheDataPreprocessor {
    
    let key: Data
    let iv: Data
    
    init() async {
        let decorator = await XCNetwork.share.en_de_decorator!
        self.key = decorator.key_data
        self.iv = decorator.iv_data
    }
    
    public func preprocess(data: Data) async throws -> Data {
        return try await AES256CBC.encrypt_async(data: data, key: self.key, iv: self.iv)
    }
    
}
