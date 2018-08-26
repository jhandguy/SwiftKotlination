import Foundation

extension Encodable {
    var json: String? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}
