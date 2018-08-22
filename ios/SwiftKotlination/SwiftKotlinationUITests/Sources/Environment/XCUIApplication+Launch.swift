import XCTest

extension XCUIApplication {
    func launch(_ coordinatorStub: CoordinatorStub, with sessionMock: URLSessionMock = URLSessionMock()) {
        launchEnvironment[CoordinatorStub.identifier] = coordinatorStub.json
        launchEnvironment[URLSessionMock.identifier] = sessionMock.json
        launch()
    }
}
