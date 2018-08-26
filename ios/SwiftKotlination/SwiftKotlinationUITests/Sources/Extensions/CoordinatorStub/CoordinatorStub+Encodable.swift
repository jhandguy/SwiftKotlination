extension CoordinatorStub: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .start:
            break
        case .openStory(let story):
            try container.encode(story, forKey: .story)
        case .openUrl(let url):
            try container.encode(url, forKey: .url)
        }
    }
}
