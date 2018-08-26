import Foundation

final class File: Codable {
    var name: String
    var `extension`: Extension
    
    enum Extension: String, Codable {
        case json
    }
    
    init(_ name: String, _ extension: Extension) {
        self.name = name
        self.`extension` = `extension`
    }
    
    var data: Data? {
        guard
            let url = Bundle(for: type(of: self)).url(forResource: name, withExtension: `extension`.rawValue),
            let data = try? Data(contentsOf: url) else {
                return nil
        }
        
        return data
    }
}
