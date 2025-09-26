import Foundation
import UIKit
import XCKeychain
import Network
import CoreTelephony

internal struct ReqDefArge {
    internal static func currentNWType() async -> String {
        let monitor = NWPathMonitor()
        let path = await monitor.path()
        let nw_type = switch path.status {
        case .satisfied:
            if path.usesInterfaceType(.wifi) {
                "WIFI"
            } else if path.usesInterfaceType(.cellular) {
                "Cellular"
            } else if path.usesInterfaceType(.wiredEthernet) {
                "Ethernet"
            } else {
                "Other"
            }
        default: "No Connection"
        }
        return nw_type.uppercased()
    }
    
    internal static func currentSimCountryCode() async -> String? {
        if #available(iOS 17.0, *) {
            return nil
        }
        let nw_info = CTTelephonyNetworkInfo()
        if #available(iOS 12.0, *) {
            if let carriers = nw_info.serviceSubscriberCellularProviders {
                for (_ , carrier) in carriers {
                    if let countryCode = carrier.isoCountryCode {
                        return countryCode.uppercased()
                    }
                }
            }
        } else {
            if let carrier = nw_info.subscriberCellularProvider {
                if let countryCode = carrier.isoCountryCode {
                    return countryCode.uppercased()
                }
            }
        }
        return nil
    }
    
    internal static func appVer() async -> Int {
        guard let verStr = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return 0
        }
        let components = verStr.components(separatedBy: ".")
        var verCode = 0
        for (index, component) in components.enumerated() {
            if let number = Int(component), index < 3 {
                switch index {
                case 0:
                    verCode = number * 100
                case 1:
                    verCode += (number % 100) * 10
                case 2:
                    verCode += (number % 10)
                default: break
                }
            }
        }
        return verCode
    }
    
    internal static func currentUUID(_ key: String) async -> String {
        return XCKeychain.getUUID(key)
    }
    
    internal static func currentPK() async -> String {
        return "com.unlimitedr.tunnel.main"
    }
    
    internal static func local() async -> String {
        let code = if #available(iOS 16, *) {
            Locale.current.region?.identifier
        } else {
            Locale.current.regionCode
        }
        return code ?? "US"
    }
    
    internal static func lang() async -> String {
        let code = if #available(iOS 16, *) {
            Locale.current.language.languageCode?.identifier
        } else {
            Locale.current.languageCode
        }
        return code ?? "en"
    }
    
    internal static func phone_SDK() async -> String {
        return await UIDevice.current.systemVersion
    }
    
    internal static func phone_model() async -> String {
        return await UIDevice.current.localizedModel
    }
    
    internal static func timezone() async -> String {
        return TimeZone.current.identifier
    }
    
    internal static func datetime() async -> Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
    
    internal static func first_install_time() async -> Int {
        return await UserDefaults.standard.integer(forKey: XCNetwork.share.userDefault_decorator.decrypt_first_install_time)
    }
    
    internal static func last_update_time() async -> Int {
        return await UserDefaults.standard.integer(forKey: XCNetwork.share.userDefault_decorator.decrypt_last_update_time)
    }
}
