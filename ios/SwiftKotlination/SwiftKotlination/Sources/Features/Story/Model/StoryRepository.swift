import RxSwift

protocol StoryRepositoryProtocol {
    var story: Observable<Story> { get }
}

struct StoryRepository: StoryRepositoryProtocol {
    var story: Observable<Story>
    
    init(_ story: Story) {
        self.story = Observable.just(story)
    }
}
