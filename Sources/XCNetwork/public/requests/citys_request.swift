import Foundation
import AES_256_CBC
import XCEvents

public struct Citys_request: Requestprotocol {
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

extension Citys_request {
    private static func _fire(timeout: TimeInterval = 20) async throws -> [Citys_response] {
        let paramaters = try await Global_config_request.create()
        let host = try await HostRequest.fire()
        let api = await XCNetwork.share.http_api_decorator.decrypt_citys
        let url = host.config_host + api
        let task = NE.fire(url, paramaters: paramaters, timeout: timeout)
        let result = try await task.serModel(Base_response<[Citys_response]>.self, dataPreprocessor: XCNetwork.share.ne_data_preprocessor).value
        return result.data ?? []
    }
    
    private static func _fire_github() async throws -> [Citys_response] {
        let url = "https://raw.githubusercontent.com/zhongyat/hh/refs/heads/main/city.txt"
        let task = NE.fire(url)
        do {
            let result = try await task.serModel(Base_response<[Citys_response]>.self, dataPreprocessor: XCNetwork.share.ne_data_preprocessor).value
            return result.data ?? []
        } catch {
            Events.error_city.fire()
            throw error
        }
    }
    
    private static func _fetch_local() async throws -> [Citys_response] {
        let aes_result = try await LocalResources.citys.read()
        let result = try JSONDecoder().decode(Base_response<[Citys_response]>.self, from: aes_result)
        try await result.w(
            encode: await XCNetwork.share.cache_encrypt_data_preprocessor,
            decode: await XCNetwork.share.cache_decrypt_data_preprocessor
        )
        return result.data ?? []
    }
    
    public static func fire(timeout: TimeInterval = 20) async throws -> [Citys_response] {
        if await XCNetwork.share.enable_local_resource {
            let expired = await Base_response<[Citys_response]>.expired()
            if expired {
                do {
                    let result = try await Citys_request._fire(timeout: timeout)
                    return result
                } catch {
                    Events.error_city_api.fire()
                    return try await Citys_request._fetch_local()
                }
            } else {
                do {
                    let cache_result = try await Base_response<[Citys_response]>.r(
                        "citys",
                        encode: await XCNetwork.share.cache_encrypt_data_preprocessor,
                        decode: await XCNetwork.share.cache_decrypt_data_preprocessor
                    )
                    if cache_result == nil {
                        return try await Citys_request._fetch_local()
                    }
                    return cache_result?.data ?? []
                } catch {
                    return try await Citys_request._fetch_local()
                }
            }
        }
        return try await Citys_request._fire()
    }
}
