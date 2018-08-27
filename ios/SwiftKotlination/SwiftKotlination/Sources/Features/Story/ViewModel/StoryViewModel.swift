struct StoryViewModel {
    let storyRepository: StoryRepositoryProtocol
}

extension StoryViewModel {
    func story(_ observer: @escaping Observer<Story>) {
        return storyRepository.story(observer)
    }
}
