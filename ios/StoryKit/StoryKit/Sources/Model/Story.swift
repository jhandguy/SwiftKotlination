public struct Story: Codable, Equatable {
    public let section: String
    public let subsection: String
    public let title: String
    public let abstract: String
    public let byline: String
    public let url: String
    public let multimedia: [Multimedia]

    public init(
        section: String,
        subsection: String,
        title: String,
        abstract: String,
        byline: String,
        url: String,
        multimedia: [Multimedia]
    ) {
        self.section = section
        self.subsection = subsection
        self.title = title
        self.abstract = abstract
        self.byline = byline
        self.url = url
        self.multimedia = multimedia
    }
}

public extension Story {
    func imageUrl(_ format: Multimedia.Format) -> String? {
        multimedia.filter { $0.format == format }.first?.url
    }
}
