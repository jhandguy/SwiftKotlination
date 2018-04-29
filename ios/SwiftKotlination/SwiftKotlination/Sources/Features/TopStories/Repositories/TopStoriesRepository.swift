protocol TopStoriesRepositoryProtocol {
    var stories: [Story] { get }
}

struct TopStoriesRepository: TopStoriesRepositoryProtocol {
    var stories: [Story] {
        return [
            Story(section: "World", subsection: "Asia Pacific", title: "Kim Prepared to Cede Nuclear Weapons if U.S. Pledges Not to Invade", abstract: "South Korean officials said the North Korean leader, Kim Jong-un, had told them he would abandon his nuclear weapons if Washington ended the Korean War and promised nonaggression.", url: "https://www.nytimes.com/2018/04/29/world/asia/north-korea-trump-nuclear.html", byline: "By CHOE SANG-HUN")
        ]
    }
}
