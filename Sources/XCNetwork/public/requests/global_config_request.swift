import Foundation
import AES_256_CBC
import XCEvents

public struct Global_config_request: Requestprotocol {
    public init() async throws {}
    
    public var platform: String!
    
    public var datetime: Int!
    
    public var simcountry: String?
    
    public var isp: String?
    
    public var ipcountry: String?
    
    public var country: String!
    
    public var local: String!
    
    public var lang: String!
    
    public var timezone: String!
    
    public var first_install_time: Int!
    
    public var last_update_time: Int!
    
    public var phone_model: String!
    
    public var network_type: String!
    
    public var phone_sdk: String!
    
    public var pk: String!
    
    public var uuid: String!
    
    public var ver: Int!
    
    public var is_vip: Int!
    
    public var is_cn: Bool!
    
}


extension Global_config_request {
    private static func _fire() async throws -> Global_config_response {
        let paramaters = try await Global_config_request.create()
        let host = try await HostRequest.fire()
        let api = await XCNetwork.share.http_api_decorator.decrypt_global_config
        let url = host.config_host + api
        let task = NE.fire(url, paramaters: paramaters)
        let result = try await task.serModel(Global_config_response.self, dataPreprocessor: XCNetwork.share.ne_data_preprocessor).value
        #if DEBUG
        NSLog("===== \(task.cURLDescription())")
        #endif
        return result
    }
    
    private static func _fetch_local() async throws -> Global_config_response {
        let aes_result = try await LocalResources.global_config.read()
        let result = try JSONDecoder().decode(Global_config_response.self, from: aes_result)
        try await result.w(
            encode: await XCNetwork.share.cache_encrypt_data_preprocessor,
            decode: await XCNetwork.share.cache_decrypt_data_preprocessor
        )
        return result
    }
    
    public static func fire() async throws -> Global_config_response {
        if await XCNetwork.share.enable_local_resource {
            let expired = await Global_config_response.expired()
            if expired {
                do {
                    let result = try await Global_config_request._fire()
                    return result
                } catch {
                    Events.error_config.fire()
                    return try await Global_config_request._fetch_local()
                }
            } else {
                do {
                    let cache_result = try await Global_config_response.r(
                        "global_config",
                        encode: await XCNetwork.share.cache_encrypt_data_preprocessor,
                        decode: await XCNetwork.share.cache_decrypt_data_preprocessor
                    )
                    if cache_result == nil {
                        return try await Global_config_request._fetch_local()
                    }
                    return cache_result!
                } catch {
                    return try await Global_config_request._fetch_local()
                }
            }
        }
        return try await Global_config_request._fire()
    }
}
