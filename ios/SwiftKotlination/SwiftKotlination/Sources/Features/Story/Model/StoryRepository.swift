import RxSwift

protocol StoryRepositoryProtocol {
    var story: Observable<Story> { get }
}

struct StoryRepository: StoryRepositoryProtocol {
    var story: Observable<Story>
    
    init(story: Story) {
        self.story = Observable.just(story)
    }
}
