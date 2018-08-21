import Foundation

enum Failure: String, Error, Codable {
    case unknown
}

enum Result<T: Codable> {
    case success(T)
    case failure(Failure)
}

extension Result: Codable {
    enum CodingKeys: String, CodingKey { case success, failure }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let result = try? values.decode(T.self, forKey: .success) {
            self = .success(result)
            return
        }
        
        if let error = try? values.decode(Failure.self, forKey: .failure) {
            self = .failure(error)
            return
        }
        
        self = .failure(.unknown)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .success(let result):
            try container.encode(result, forKey: .success)
        case .failure(let error):
            try container.encode(error, forKey: .failure)
        }
    }
}
