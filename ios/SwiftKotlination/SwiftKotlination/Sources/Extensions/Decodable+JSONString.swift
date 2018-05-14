import Foundation

extension Decodable {
    static func decode(from jsonString: String) -> Self? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        
        return try? JSONDecoder().decode(self, from: jsonData)
    }
}
