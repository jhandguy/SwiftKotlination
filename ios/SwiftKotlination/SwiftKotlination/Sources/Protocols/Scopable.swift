import Foundation
import CoreGraphics
import UIKit.UIGeometry

protocol Scopable {}

extension Scopable where Self: Any {

    func also(_ closure: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try closure(&copy)
        return copy
    }

    func run(_ closure: (Self) throws -> Void) rethrows {
        try closure(self)
    }
}

extension Scopable where Self: AnyObject {

    func with(_ closure: (Self) throws -> Void) rethrows -> Self {
        try closure(self)
        return self
    }

    func runOnMainThread(_ closure: @escaping (Self) throws -> Void) rethrows {
        if Thread.isMainThread {
            try run(closure)
        } else {
            DispatchQueue.main.async(execute: { [weak self] in
                try? self?.run(closure)
            })
        }
    }
}

extension NSObject: Scopable {}

extension UIEdgeInsets: Scopable {}
extension UIOffset: Scopable {}
extension UIRectEdge: Scopable {}

extension CGPoint: Scopable {}
extension CGRect: Scopable {}
extension CGSize: Scopable {}
extension CGVector: Scopable {}
