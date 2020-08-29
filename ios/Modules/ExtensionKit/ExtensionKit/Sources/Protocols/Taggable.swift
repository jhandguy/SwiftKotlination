public protocol Taggable {
    static var tag: String { get }
}

public extension Taggable {
    static var tag: String {
        String(describing: self)
    }
}
