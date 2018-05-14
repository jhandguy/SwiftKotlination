import Alamofire

struct Request: Hashable {
    var method: Alamofire.HTTPMethod
    var path: String
    
    init(_ method: Alamofire.HTTPMethod, _ path: String) {
        self.method = method
        self.path = path
    }
}

extension Request: Codable {
    private enum CodingKeys: String, CodingKey {
        case method
        case path
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.method = Alamofire.HTTPMethod(rawValue: try container.decode(String.self, forKey: .method))!
        self.path = try container.decode(String.self, forKey: .path)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(method.rawValue, forKey: .method)
        try container.encode(path, forKey: .path)
    }
}
