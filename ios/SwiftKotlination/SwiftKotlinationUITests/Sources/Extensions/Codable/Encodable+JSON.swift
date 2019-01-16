import Foundation

extension Encodable {

    // MARK: - Internal Properties

    var json: String? {
        guard let data = data else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
}
