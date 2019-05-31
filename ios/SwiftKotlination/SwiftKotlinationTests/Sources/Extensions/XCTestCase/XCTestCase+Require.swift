import XCTest

extension XCTestCase {

    private struct RequireError<T>: LocalizedError {
        let file: StaticString
        let line: UInt

        var errorDescription: String? {
            return "Required value of type \(T.self) was nil at line \(line) in file \(file)"
        }
    }

    func require<T>(_ expression: @autoclosure () -> T?, file: StaticString = #file, line: UInt = #line) throws -> T {
        guard let value = expression() else {
            throw RequireError<T>(file: file, line: line)
        }

        return value
    }
}
