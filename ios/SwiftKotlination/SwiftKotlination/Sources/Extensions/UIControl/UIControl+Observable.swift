import UIKit

extension UIControl {

    typealias Observer = () -> Void

    private class Observable: NSObject {
        static var key = String(describing: self)
        let observer: Observer

        init(_ observer: @escaping Observer) {
            self.observer = observer
        }
    }

    // MARK: - Private Properties

    private var observer: Observer {
        get {
            guard let observable = objc_getAssociatedObject(self, &Observable.key) as? Observable else {
                return {}
            }

            return observable.observer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &Observable.key, Observable(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: - Private Methods

    @objc
    private func observe() {
        observer()
    }

    // MARK: - Internal Methods

    func on(_ controlEvents: UIControlEvents, _ observer: @escaping Observer) {
        self.observer = observer
        addTarget(self, action: #selector(observe), for: controlEvents)
    }
}
