struct Story: Codable, Equatable {
    let section: String
    let subsection: String
    let title: String
    let abstract: String
    let byline: String
    let url: String
    let multimedia: [Multimedia]
}

extension Story {
    func imageUrl(_ format: Multimedia.Format) -> String? {
        return multimedia.filter { $0.format == format }.first?.url
    }
}
