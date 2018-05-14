import Foundation

extension Encodable {
    var encodedJSONString: String {
        guard let jsonString = String(data: encodedJSONData, encoding: .utf8) else {
            fatalError("Couldn't cast \(encodedJSONData) to String")
        }
        
        return jsonString
    }
    
    var encodedJSONData: Data {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            fatalError("Couldn't encode \(self) to a JSON String")
        }
        
        return jsonData
    }
}
