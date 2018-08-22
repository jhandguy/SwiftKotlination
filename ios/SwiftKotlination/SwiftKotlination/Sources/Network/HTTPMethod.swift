enum HTTPMethod: String {
    case post
    case put
    case get
    case delete
    case patch
    
    var name: String {
        return rawValue.uppercased()
    }
}
