import ExtensionKit

public enum NetworkError: String, ErrorStringConvertible, Codable {
    case invalidData
    case invalidResponse
    case invalidRequest

    public var description: String {
        switch self {
        case .invalidRequest:
            return "Invalid request, please try again later."
        case .invalidResponse:
            return "Invalid response, please try again later."
        case .invalidData:
            return "Invalid data, please try again later."
        }
    }
}
