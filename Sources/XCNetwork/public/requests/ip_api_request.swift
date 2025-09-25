import Foundation
import VPNConnectionChecker

internal struct IPApiRequest {
    private static func _fire() async throws -> IPConfig {
        let task = NE.fire(
            await XCNetwork.share.ipconfig_decorator.decrypt_url_1,
            interceptor: await XCNetwork.share.ne_request_interceptor
        ) { request in
            request.timeoutInterval = 5
        }
        let result = try await task.serModel(Ip_api_response.self).value
        return result
    }
    
    private static func def() async -> Ip_api_response {
        return Ip_api_response(
            asn: await ReqDefArge.local(),
            org: "",
            country_code: await ReqDefArge.local()
        )
    }
    
    internal static func fire() async throws -> IPConfig {
        let encode = await XCNetwork.share.cache_encrypt_data_preprocessor!
        let decode = await XCNetwork.share.cache_decrypt_data_preprocessor!
        let expired = await Ip_api_response.expired()
        if expired {
            if await VPNConnectionChecker.checker() == false {
                let result = try await IPApiRequest._fire()
                if await VPNConnectionChecker.checker() == false {
                    try await result.w(encode: encode, decode: decode)
                    return result
                }
            }
        }
        return if let result = try await Ip_api_response.r(nil, encode: encode, decode: decode) {
            result
        } else {
            await IPApiRequest.def()
        }
    }
}
