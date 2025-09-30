import Foundation
import VPNConnectionChecker

public struct IPInfoRequest {
    private static func _fire() async throws -> IPConfig {
        let task = NE.fire(
            await XCNetwork.share.ipconfig_decorator.decrypt_url_2,
            interceptor: await XCNetwork.share.ne_request_interceptor
        ) { request in
            request.timeoutInterval = 5
        }
        let result = try await task.serModel(Ip_info_response.self).value
        return result
    }
    
    private static func def() async -> Ip_info_response {
        return Ip_info_response(country: await ReqDefArge.local(), org: await ReqDefArge.local())
    }
    
    public static func fire() async -> IPConfig {
        do {
            let encode = await XCNetwork.share.cache_encrypt_data_preprocessor!
            let decode = await XCNetwork.share.cache_decrypt_data_preprocessor!
            let expired = await Ip_info_response.expired()
            if expired {
                if await VPNConnectionChecker.checker() == false {
                    let result = try await IPInfoRequest._fire()
                    if await VPNConnectionChecker.checker() == false {
                        try await result.w(encode: encode, decode: decode)
                        return result
                    }
                }
            }
            return if let result = try await Ip_info_response.r(nil, encode: encode, decode: decode)
            {
                result
            } else {
                await IPInfoRequest.def()
            }
        } catch {
            return await IPInfoRequest.def()
        }
    }
}

