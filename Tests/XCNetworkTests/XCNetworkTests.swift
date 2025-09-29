import Testing
import Foundation
@testable import XCNetwork
// xcnetwork.XCNetworkTests

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

func setNetwork() async throws {
    try await XCNetwork.share.setEnDe(.init(key: "kJolMg7JMLK2nJ31oK6P5+okn26aoJmKRwMX5GOynz0=", iv: "YC3IYFlVgc7kPlAAWTvPmw=="))
    try await XCNetwork.share.setIpconfig(.init(url_1: "SZtor7k74u4prgV/wb92JIf84RkO0pSrqYAlOG73/tk=", url_2: "nMvzOk4mW4Nq5H3ZQL+0fYnRqoTzEbgrkApOMF79Tnk=", url_3: ""))
    try await XCNetwork.share.setUA(.init(ua: "PMZz9g1hVUSbc8TOzpN8rf0mN1Khi1S+/qPSBrDUH9rXyg2cCIWBsWi6yj6iJrl3lwe/BLDzUV6tqRANXbEOQjTUElKRswqCsPUay8Ffq3ixBdiZuyUXgcgcVRbIkUT+mm4nW6Fv/MV2/DCxSIU0QE/w0Yvji3/uflgtUt31R6A="))
    try await XCNetwork.share.setHttpApi(
        .init(
            host: "7fQeVDwzefo4ZaLRqKbH3YxHx6LG1D7I3bV3uUoyY/GyD3n9qS406dFg72tSLoNKMccTr0QlmRizKh90bE7HMCVmXbVPH3RqryyDJFxM55s=",
            citys: "G+kcAB4Q2u5RJVPCYvarQQ==",
            global_config: "Pbb0c4kHsxFaeVAkO35Ukw==",
            node: "Ltq0HEyzSjhnAUNbeTIRLw==",
            report: "a4/1T8A8xmtmumoF98xY8w=="
        )
    )
    try await XCNetwork.share.setUD(.init(first_install_time: "X/qc0jEzO6OzCNueV3KezSbb7T3pSu/jrQtjr3I/kX0=", last_update_time: "xB2Nh3ACwkmx0Fld9WLk/RYQVrf4Xy6THFTXddlNAXQ="))
    try await XCNetwork.share.setKeyChain(.init(key_uuid: "mnCm0wLU/h33Tk+O445HRz2+T/NzQePrVAYU5FOnzRg="))
    await XCNetwork.share.setCache_decrypt_data_preprocessor(.init())
    await XCNetwork.share.setCache_encrypt_data_preprocessor(.init())
    await XCNetwork.share.setNEDataPreprocessor(.init())
    await XCNetwork.share.setNERequestInterceptor(.init())
}

@Test func ipconfig() async throws {
    try await setNetwork()

    let result = try await IPConfiguration.fire()
    
    print(result)
}

@Test func host() async throws {
    try await setNetwork()
    let result = try await HostRequest.fire()
    print(result)
}

@Test("global_config")
func global_config() async throws {
    try await setNetwork()
    let result = try await Global_config_request.fire()
    print(result)
}

@Test("citys")
func citys() async throws {
    try await setNetwork()
    let result = try await Citys_request.fire()
    print(result)
}

@Test("node")
func node() async throws {
    try await setNetwork()
    await XCNetwork.share.setEnable_local_resource(false)
    let citys = try await Citys_request.fire()
    guard let first = citys.first else { throw NSError(domain: "citys is empty", code: -1) }
    let result = try await Node_request.fire(first.id)
    print(result)
}

@Test("report")
func report() async throws {
    try await setNetwork()
    await XCNetwork.share.setEnable_local_resource(false)
    let citys = try await Citys_request.fire()
    guard let first_city = citys.first else { throw NSError(domain: "citys is empty", code: -1) }
    let nodes = try await Node_request.fire(first_city.id)
    guard let first_node = nodes.first else { throw NSError(domain: "nodes is empty", code: -1) }
    try await Report_request.fire(
        name: first_node.name,
        retry: 0,
        core: first_node.core,
        agreement: first_node.agreement,
        event: "connect"
    )
}

@Test("nodes_github")
func nodes_github() async throws {
    try await setNetwork()
    
    let nodes = try await Node_github_request.fire("CN")
    print(nodes)
}
