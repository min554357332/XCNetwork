import Foundation

public protocol Requestprotocol: Sendable, Codable {
    var platform: String! { set get }
    var datetime: Int! { set get }
    var simcountry: String? { set get }
    var isp: String? { set get }
    var ipcountry: String? { set get }
    var country: String! { set get }
    var local: String! { set get }
    var lang: String! { set get }
    var timezone: String! { set get }
    var first_install_time: Int! { set get }
    var last_update_time: Int! { set get }
    var phone_model: String! { set get }
    var network_type: String! { set get }
    var phone_sdk: String! { set get }
    var pk: String! { set get }
    var uuid: String! { set get }
    var ver: Int! { set get }
    var is_vip: Int! { set get }
    var is_cn: Bool! { set get }
    
    init() async throws
}

public extension Requestprotocol {
    static func create() async throws -> Self {
        let ip_config = try await IPConfiguration.fire()
        var request = try await Self()
        request.platform = "ios"
        request.datetime = await ReqDefArge.datetime()
        request.simcountry = await ReqDefArge.currentSimCountryCode()
        request.isp = ip_config.isp
        request.ipcountry = ip_config.ipcountry
        request.country = try await ReqDefArge.country()
        request.local = await ReqDefArge.local()
        request.lang = await ReqDefArge.lang()
        request.timezone = await ReqDefArge.timezone()
        request.first_install_time = await ReqDefArge.first_install_time()
        request.last_update_time = await ReqDefArge.last_update_time()
        request.phone_model = await ReqDefArge.phone_model()
        request.network_type = await ReqDefArge.currentNWType()
        request.phone_sdk = await ReqDefArge.phone_SDK()
        request.pk = await ReqDefArge.currentPK()
        request.uuid = await ReqDefArge.currentUUID(XCNetwork.share.keyChain_decorator.decrypt_key_uuid)
        request.ver = await ReqDefArge.appVer()
        request.is_vip = 0
        request.is_cn = false
        return request
    }
}

