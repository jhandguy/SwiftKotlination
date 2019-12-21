import Foundation

public extension Encodable {
    var json: String? {
        guard let data = data else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    var data: Data? {
        try? JSONEncoder().encode(self)
    }
}
