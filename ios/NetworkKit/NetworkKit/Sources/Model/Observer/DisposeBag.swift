public final class DisposeBag {
    public internal(set) var disposables: [Disposable]

    public init(disposables: [Disposable] = []) {
        self.disposables = disposables
    }

    public func dispose() {
        disposables.forEach { $0.closure() }
        disposables = []
    }
}
