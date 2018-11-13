import Foundation

enum CoordinatorStub: Identifiable {
    case openStory(Story)
    case openUrl(URL)
    case start
}

extension CoordinatorStub {
    enum CodingKeys: String, CodingKey { case story, url }
}
