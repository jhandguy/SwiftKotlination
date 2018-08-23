enum NetworkError: String, ErrorStringConvertible, Codable {
    case invalidResponse
    
    var description: String {
        switch self {
        case .invalidResponse:
            return "Invalid response, please try again later."
        }
    }
}
