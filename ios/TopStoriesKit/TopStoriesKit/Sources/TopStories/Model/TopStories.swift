import StoryKit

public struct TopStories: Codable {
    let results: [Story]

    public init(results: [Story]) {
        self.results = results
    }
}
