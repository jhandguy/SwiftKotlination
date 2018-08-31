final class DisposeBag {
    var disposables: [Disposable] = []
    
    func dispose() {
        disposables.forEach { $0.closure() }
        disposables = []
    }
}
