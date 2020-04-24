import NetworkKit
import XCTest

final class SafariRobot: Robot {
    private lazy var urlButton  = app.buttons["URL"]
    private lazy var doneButton = app.buttons["Done"]

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

        assert(urlButton, [.isHittable, .isLike("*\(host)*")])

        return self
    }

    @discardableResult
    func closeSafari() -> Self {
        tap(doneButton)

        return self
    }
}
