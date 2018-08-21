import Foundation

enum Parameters {
    case body(Data)
    case url([String: String?])
    case none
}

extension Parameters: Codable {
    enum CodingKeys: String, CodingKey { case body, url, none }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let parameters = try? values.decode(Data.self, forKey: .body) {
            self = .body(parameters)
            return
        }
        
        if let parameters = try? values.decode([String: String?].self, forKey: .url) {
            self = .url(parameters)
            return
        }
        
        self = .none
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .body(let parameters):
            try container.encode(parameters, forKey: .body)
        case .url(let parameters):
            try container.encode(parameters, forKey: .url)
        case .none:
            return
        }
    }
}
