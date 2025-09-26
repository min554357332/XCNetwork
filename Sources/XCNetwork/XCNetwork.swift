import Foundation
import AES_256_CBC

public actor XCNetwork {
    public static let share: XCNetwork = .init()
    
    public private(set) var app_groups_decorator: App_groups_decorator!
    public private(set) var en_de_decorator: Aes256cbc_decorator!
    public private(set) var http_api_decorator: HttpApi_decorator!
    public private(set) var userDefault_decorator: UserDefault_decorator!
    public private(set) var keyChain_decorator: KeyChain_decorator!
    public private(set) var ipconfig_decorator: Ipconfig_decorator!
    public private(set) var ua_decorator: UA_decorator!
    
    public private(set) var ne_data_preprocessor: NEDataPreprocessor!
    public private(set) var ne_request_interceptor: NERequestInterceptor!
    
    public private(set) var cache_decrypt_data_preprocessor: CacheDecryptDataPreprocessor!
    public private(set) var cache_encrypt_data_preprocessor: CacheEncryptDataPreprocessor!
    
    public private(set) var enable_local_resource = true
    
    public private(set) var enable_cache = true
    
    private init() {}
}

extension XCNetwork {
    public func setAppGroups(_ decorator: App_groups_decorator) async {
        self.app_groups_decorator = decorator
    }
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






