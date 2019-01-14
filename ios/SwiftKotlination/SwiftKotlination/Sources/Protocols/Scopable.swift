import Foundation
import CoreGraphics
import UIKit.UIGeometry

protocol Scopable {}

extension Scopable where Self: AnyObject {

    func with(_ closure: (Self) throws -> Void) rethrows -> Self {
        try closure(self)
        return self
    }

    func apply(onMainThread: Bool = false, _ closure: @escaping (Self) throws -> Void) rethrows {
        guard !Thread.isMainThread && onMainThread else {
            try closure(self)
            return
        }

        DispatchQueue.main.async(
            execute: { [weak self] in
                guard let self = self else { return }
                try? closure(self)
            }
        )
        return
    }
}

extension NSObject: Scopable {}
