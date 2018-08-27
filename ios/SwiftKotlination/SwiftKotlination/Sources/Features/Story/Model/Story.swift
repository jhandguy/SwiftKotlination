struct Story: Codable, Equatable {
    let section: String
    let subsection: String
    let title: String
    let abstract: String
    let byline: String
    let url: String
    let multimedia: [Mutlimedia]
}

extension Story {
    func firstImageUrl(_ format: Mutlimedia.Format) -> String? {
        return multimedia.filter { $0.format == .small }.first?.url
    }
}
