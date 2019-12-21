import Foundation

public final class File: Codable {
    var name: String
    var `extension`: Extension

    public enum Extension: String, Codable {
        case json
        case jpg
    }

    public init(_ name: String, _ extension: Extension) {
        self.name = name
        self.extension = `extension`
    }

    public var data: Data? {
        guard
            let url = Bundle(for: type(of: self)).url(forResource: name, withExtension: `extension`.rawValue),
            let data = try? Data(contentsOf: url) else {
            return nil
        }

        return data
    }
}
