struct File: Codable {
    let name: String
    let `extension`: Extension
    
    enum Extension: String, Codable {
        case json
    }
}
