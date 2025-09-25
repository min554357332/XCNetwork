import Foundation
import AES_256_CBC

public struct HostRequest {
    
    private static func _fire() async throws -> Host_response {
        let url = await XCNetwork.share.http_api_decorator.decrypt_host
        let task = NE.fire(url)
        let result = try await task.serModel(Host_response.self, dataPreprocessor: await XCNetwork.share.ne_data_preprocessor).value
        try await result.w(
            encode: await XCNetwork.share.cache_encrypt_data_preprocessor,
            decode: await XCNetwork.share.cache_decrypt_data_preprocessor
        )
        return result
    }
    
    private static func _fetch_local() async throws -> Host_response {
        let aes_result = try await LocalResources.host.read()
        let result = try JSONDecoder().decode(Host_response.self, from: aes_result)
        try await result.w(
            encode: await XCNetwork.share.cache_encrypt_data_preprocessor,
            decode: await XCNetwork.share.cache_decrypt_data_preprocessor
        )
        return result
    }
    
    public static func fire() async throws -> Host_response {
        if await XCNetwork.share.enable_local_resource {
            let expired = await Host_response.expired()
            if expired {
                do {
                    return try await HostRequest._fire()
                } catch {
                    print(error)
                    return try await HostRequest._fetch_local()
                }
            } else {
                do {
                    let cache_result = try await Host_response.r(
                        "host",
                        encode: await XCNetwork.share.cache_encrypt_data_preprocessor,
                        decode: await XCNetwork.share.cache_decrypt_data_preprocessor
                    )
                    if cache_result == nil {
                        return try await HostRequest._fetch_local()
                    }
                    return cache_result!
                } catch {
                    print(error)
                    return try await HostRequest._fetch_local()
                }
            }
        }
        return try await HostRequest._fire()
    }
}
