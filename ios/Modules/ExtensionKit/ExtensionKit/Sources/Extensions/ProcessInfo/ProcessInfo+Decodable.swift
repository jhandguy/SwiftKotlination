import Foundation

public extension ProcessInfo {
    func decode<T: Taggable & Decodable>(_: T.Type) -> T? {
        guard
            let environment = environment[T.tag],
            let codable = T.decode(from: environment) else {
            return nil
        }

        return codable
    }
}
