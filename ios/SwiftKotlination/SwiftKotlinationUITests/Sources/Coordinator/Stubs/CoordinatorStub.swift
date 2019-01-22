enum CoordinatorStub: Identifiable {
    case openStory(Story)
    case openUrl(String)
    case start
}

extension CoordinatorStub {
    enum CodingKeys: String, CodingKey { case story, url }
}
