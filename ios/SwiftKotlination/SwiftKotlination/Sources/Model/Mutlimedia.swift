struct Mutlimedia: Codable, Equatable {
    let url: String
    let format: Format
    
    enum Format: String, Codable {
        case icon = "Standard Thumbnail"
        case small = "thumbLarge"
        case normal = "Normal"
        case medium = "mediumThreeByTwo210"
        case large = "superJumbo"
    }
}
