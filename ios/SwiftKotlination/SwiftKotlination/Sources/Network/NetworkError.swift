enum NetworkError: String, ErrorStringConvertible, Codable {
    case invalidResponse
    case invalidRequest
    
    var description: String {
        switch self {
        case .invalidRequest:
            return "Invalid request, please try again later."
        case .invalidResponse:
            return "Invalid response, please try again later."
        }
    }
}
