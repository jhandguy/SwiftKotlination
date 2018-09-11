struct Disposable {
    let closure: () -> Void
}

extension Disposable {

    // MARK: - Internal Methods

    func disposed(by disposeBag: DisposeBag) {
        disposeBag.disposables.append(self)
    }
}
