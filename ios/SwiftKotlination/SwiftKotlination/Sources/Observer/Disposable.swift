struct Disposable {
    let closure: () -> Void
}

extension Disposable {

    func disposed(by disposeBag: DisposeBag) {
        disposeBag.disposables.append(self)
    }
}
