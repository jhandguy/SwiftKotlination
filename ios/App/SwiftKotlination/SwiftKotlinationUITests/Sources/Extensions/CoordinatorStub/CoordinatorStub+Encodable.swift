extension CoordinatorStub: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .start:
            break
        case let .openStory(story):
            try container.encode(story, forKey: .story)
        case let .openUrl(url):
            try container.encode(url, forKey: .url)
        }
    }
}
