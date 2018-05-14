import XCTest

extension XCUIApplication {
    
    func launch(_ coordinatorStub: CoordinatorStub, with apiClientMock: APIClientMock = APIClientMock(responses: [:])) {
        launchEnvironment[CoordinatorStub.key] = coordinatorStub.encodedJSONString
        launchEnvironment[APIClientMock.key] = apiClientMock.encodedJSONString
        launch()
    }
}
