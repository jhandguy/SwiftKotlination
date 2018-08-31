import XCTest
@testable import SwiftKotlination

final class DisposeBagTest: XCTestCase {
    
    var sut: DisposeBag!
    
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
