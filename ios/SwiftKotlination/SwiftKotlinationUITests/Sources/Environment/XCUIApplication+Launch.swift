import XCTest

extension XCUIApplication {
    
    func launch(_ coordinatorMock: CoordinatorMock, with apiClientMock: APIClientMock = APIClientMock(responses: [:])) {
        launchEnvironment[CoordinatorMock.key] = coordinatorMock.encodedJSONString
        launchEnvironment[APIClientMock.key] = apiClientMock.encodedJSONString
        launch()
    }
}
