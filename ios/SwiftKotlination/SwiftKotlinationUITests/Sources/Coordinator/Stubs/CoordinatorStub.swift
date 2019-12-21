import ExtensionKit
import StoryKit

enum CoordinatorStub: Taggable {
    case openStory(Story)
    case openUrl(String)
    case start
}

extension CoordinatorStub {
    enum CodingKeys: String, CodingKey { case story, url }
}
