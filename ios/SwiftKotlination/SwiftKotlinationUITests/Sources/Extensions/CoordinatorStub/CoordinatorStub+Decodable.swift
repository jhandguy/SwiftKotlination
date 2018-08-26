import Foundation

extension CoordinatorStub: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let story = try? values.decode(Story.self, forKey: .story) {
            self = .openStory(story)
            return
        }
        
        if let url = try? values.decode(URL.self, forKey: .url) {
            self = .openUrl(url)
            return
        }
        
        self = .start
    }
}
