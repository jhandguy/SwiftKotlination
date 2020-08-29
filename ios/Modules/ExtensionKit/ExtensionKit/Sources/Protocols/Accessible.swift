import UIKit

public protocol Accessible {
    func generateAccessibilityIdentifiers()
}

public extension Accessible {
    func generateAccessibilityIdentifiers() {
        let mirror = Mirror(reflecting: self)

        for child in mirror.children {
            if
                let view = child.value as? UIView,
                let identifier = child
                .label?
                .replacingOccurrences(of: ".storage", with: "")
                .replacingOccurrences(of: "$__lazy_storage_$_", with: "") {
                view.accessibilityIdentifier = "\(type(of: self)).\(identifier)"
            }
        }
    }
}
