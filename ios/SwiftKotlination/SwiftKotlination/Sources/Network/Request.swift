import Foundation

enum Request: Hashable {
    case fetchImage(String)
    case fetchTopStories

    var url: String {
        switch self {
        case .fetchTopStories:
            return "https://api.nytimes.com/svc/topstories/v2/home.json"
        case .fetchImage(let url):
            return url
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchTopStories,
             .fetchImage:
            return .get
        }
    }

    var parameters: Parameters {
        switch self {
        case .fetchTopStories:
            return .url(["api-key": "de87f25eb97b4f038d8360e0de22e1dd"])
        case .fetchImage:
            return .none
        }
    }
}
