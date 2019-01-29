import Foundation

extension ProcessInfo {

    // MARK: - Internal Methods

    func decode<T: Identifiable & Decodable>(_: T.Type) -> T? {
        guard
            let environment = environment[T.identifier],
            let codable = T.decode(from: environment) else {
                return nil
        }

        return codable
    }
}
