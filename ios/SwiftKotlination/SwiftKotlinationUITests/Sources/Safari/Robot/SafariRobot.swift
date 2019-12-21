import NetworkKit
import XCTest

final class SafariRobot: Robot {
    @discardableResult
    func start(with url: String, sessionMock: URLSessionMock = URLSessionMock(), and animationStub: AnimationStub = .disableAnimations) -> Self {
        start(.openUrl(url), with: sessionMock, and: animationStub)

        return self
    }

    @discardableResult
    func checkURL(contains string: String) -> Self {
        guard let url = URL(string: string) else {
            XCTFail("[\(self)] Invalid URL \(string)")
            return self
        }

        guard let host = url.host?.replacingOccurrences(of: "www.", with: "") else {
            XCTFail("[\(self)] Invalid host in \(url.absoluteString)")
            return self
        }

        let button = app.buttons["URL"]
        assert(button, [.isHittable])

        guard let value = button.value as? String else {
            XCTFail("[\(self)] Invalid value of button \(button.description)")
            return self
        }

        XCTAssertTrue(value.contains(host))

        return self
    }

    @discardableResult
    func closeSafari() -> Self {
        tap(app.buttons["Done"])

        return self
    }
}
