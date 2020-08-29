public struct Multimedia: Codable, Equatable {
    let url: String
    let format: Format

    public init(url: String, format: Format) {
        self.url = url
        self.format = format
    }

    public enum Format: String, Codable {
        case icon = "Standard Thumbnail"
        case small = "thumbLarge"
        case normal = "Normal"
        case medium = "mediumThreeByTwo210"
        case large = "superJumbo"
    }
}
