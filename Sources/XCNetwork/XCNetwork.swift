import Foundation
import AES_256_CBC

public actor XCNetwork {
    public static let share: XCNetwork = .init()
    
    internal var en_de_decorator: Aes256cbc_decorator!
    internal var http_api_decorator: HttpApi_decorator!
    internal var userDefault_decorator: UserDefault_decorator!
    internal var keyChain_decorator: KeyChain_decorator!
    internal var ipconfig_decorator: Ipconfig_decorator!
    internal var ua_decorator: UA_decorator!
    
    internal var ne_data_preprocessor: NEDataPreprocessor!
    internal var ne_request_interceptor: NERequestInterceptor!
    
    internal var cache_decrypt_data_preprocessor: CacheDecryptDataPreprocessor!
    internal var cache_encrypt_data_preprocessor: CacheEncryptDataPreprocessor!
    
    internal var enable_local_resource = true
    
    internal var enable_cache = true
    
    private init() {}
}

extension XCNetwork {
    public func setEnDe(_ decorator: Aes256cbc_decorator) async {
        self.en_de_decorator = decorator
    }
    public func setHttpApi(_ decorator: HttpApi_decorator) async {
        self.http_api_decorator = decorator
    }
    public func setUD(_ decorator: UserDefault_decorator) async {
        self.userDefault_decorator = decorator
    }
    public func setKeyChain(_ decorator: KeyChain_decorator) async {
        self.keyChain_decorator = decorator
    }
    public func setIpconfig(_ decorator: Ipconfig_decorator) async {
        self.ipconfig_decorator = decorator
    }
    public func setUA(_ decorator: UA_decorator) async {
        self.ua_decorator = decorator
    }
    public func setNEDataPreprocessor(_ val: NEDataPreprocessor) async {
        self.ne_data_preprocessor = val
    }
    public func setNERequestInterceptor(_ val: NERequestInterceptor) async {
        self.ne_request_interceptor = val
    }
    public func setCache_decrypt_data_preprocessor(_ val: CacheDecryptDataPreprocessor) async {
        self.cache_decrypt_data_preprocessor = val
    }
    public func setCache_encrypt_data_preprocessor(_ val: CacheEncryptDataPreprocessor) async {
        self.cache_encrypt_data_preprocessor = val
    }
    public func setEnable_local_resource(_ val: Bool) async {
        self.enable_local_resource = val
    }
    public func setEnable_cache(_ val: Bool) async {
        self.enable_cache = val
    }
}






