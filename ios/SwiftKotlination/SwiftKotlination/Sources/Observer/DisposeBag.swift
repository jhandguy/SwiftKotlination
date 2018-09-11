final class DisposeBag {

    // MARK: - Internal Properties

    var disposables: [Disposable] = []

    // MARK: - Internal Methods

    func dispose() {
        disposables.forEach { $0.closure() }
        disposables = []
    }
}
