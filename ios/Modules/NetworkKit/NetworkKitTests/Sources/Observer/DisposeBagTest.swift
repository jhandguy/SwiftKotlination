@testable import NetworkKit
import XCTest

final class DisposeBagTest: XCTestCase {
    private var sut: DisposeBag!

    override func setUp() {
        super.setUp()

        sut = DisposeBag()
    }

    func testDisposeBagDisposesSuccessfully() {
        var isDisposed = false
        let disposable = Disposable {
            isDisposed = true
        }

        disposable.disposed(by: sut)

        XCTAssertFalse(sut.disposables.isEmpty)

        sut.dispose()

        XCTAssertTrue(isDisposed)
        XCTAssertTrue(sut.disposables.isEmpty)
    }
}
