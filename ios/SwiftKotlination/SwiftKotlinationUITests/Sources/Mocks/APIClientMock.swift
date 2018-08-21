import Foundation

final class APIClientMock: APIClientProtocol {
    static let key = "APIClientMock"
    
    private var responses: [Request: [Result<Data>]]
    private var observers: [Request: [(Result<Data>) -> Void]]
    
    init(responses: [Request: [Result<Data>]]) {
        self.responses = responses
        self.observers = [:]
    }
    
    func subscribe(to request: Request, _ closure: @escaping (Result<Data>) -> Void) {
        var closures = observers[request] ?? []
        closures.append(closure)
        observers[request] = closures
        
        execute(request: request)
    }
    
    func execute(request: Request) {
        guard
            let closures = observers[request],
            var results = responses[request],
            !results.isEmpty else {
            return
        }
        
        closures.forEach { $0(results.removeLast()) }
    }
}

extension APIClientMock: Codable {
    enum CodingKeys: String, CodingKey { case responses }

    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let responses = try values.decode([Request: [Result<Data>]].self, forKey: .responses)
        
        self.init(responses: responses)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(responses, forKey: .responses)
    }
}
