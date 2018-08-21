import Foundation

enum Request: String, Codable {
    case fetchTopStories
    
    var url: String {
        switch self {
        case .fetchTopStories:
            return "https://api.nytimes.com/svc/topstories/v2/home.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchTopStories:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .fetchTopStories:
            return .url(["api-key": "de87f25eb97b4f038d8360e0de22e1dd"])
        }
    }
}
