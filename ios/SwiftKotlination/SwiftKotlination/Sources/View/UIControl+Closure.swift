import UIKit

extension UIControl {
    typealias Closure = () -> ()
    
    private class Container: NSObject {
        static var key = String(describing: self)
        let closure: Closure
        
        init(_ closure: @escaping Closure) {
            self.closure = closure
        }
    }
    
    private var closure: Closure {
        get {
            guard let container = objc_getAssociatedObject(self, &Container.key) as? Container else {
                return {}
            }
            
            return container.closure
        }
        set(newValue) {
            objc_setAssociatedObject(self, &Container.key, Container(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc
    private func executeClosure() {
        closure()
    }
    
    func on(_ controlEvents: UIControlEvents, _ closure: @escaping Closure) {
        self.closure = closure
        addTarget(self, action: #selector(executeClosure), for: controlEvents)
    }
}
