import Foundation
import Network

extension NWPathMonitor {
    func path() async -> NWPath {
        self.start(queue: .init(label: "NW"))
        let result = await withUnsafeContinuation { c in
            self.pathUpdateHandler = { path in
                c.resume(returning: path)
            }
        }
        self.cancel()
        return result
    }
}
