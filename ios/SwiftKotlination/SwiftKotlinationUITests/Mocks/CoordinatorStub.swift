enum CoordinatorStub {
    static let key = "CoordinatorStub"
    
    case start
    case open(Story)
}

extension CoordinatorStub: Codable {
    enum CodingKeys: String, CodingKey { case startTopStories, openStory }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let story = try? values.decode(Story.self, forKey: .openStory) {
            self = .open(story)
            return
        }
        
        self = .start
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .start:
            break
        case let .open(story):
            try container.encode(story, forKey: .openStory)
        }
    }
}
