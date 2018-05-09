import UIKit

extension UIControl {
    
    typealias Closure = () -> ()
    
    class ClosureWrapper: NSObject {
        let closure: Closure
        init(_ closure: @escaping Closure) {
            self.closure = closure
        }
    }
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: Closure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func on(_ controlEvents: UIControlEvents, _ closure: @escaping Closure) {
        targetClosure = closure
        addTarget(self, action: #selector(closureAction), for: controlEvents)
    }
    
    @objc
    func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure()
    }
}
