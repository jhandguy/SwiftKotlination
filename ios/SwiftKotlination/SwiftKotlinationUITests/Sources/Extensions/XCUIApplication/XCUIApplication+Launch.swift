import XCTest

extension XCUIApplication {
    func launch(_ coordinatorStub: CoordinatorStub, with sessionMock: URLSessionMock = URLSessionMock(), and animationStub: AnimationStub = .disableAnimations) {
        launchEnvironment[CoordinatorStub.identifier] = coordinatorStub.json
        launchEnvironment[URLSessionMock.identifier] = sessionMock.json
        launchEnvironment[AnimationStub.identifier] = animationStub.json
        launch()
    }
}
