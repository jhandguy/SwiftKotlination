struct Disposable {
    let closure: () -> Void
}

// MARK: - Internal Methods

extension Disposable {
    func disposed(by disposeBag: DisposeBag) {
        disposeBag.disposables.append(self)
    }
}
