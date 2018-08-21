import Foundation

extension Encodable {
    var encodedJSONString: String? {
        guard let data = encodedJSONData else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    var encodedJSONData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
