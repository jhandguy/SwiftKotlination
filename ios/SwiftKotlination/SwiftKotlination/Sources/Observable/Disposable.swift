struct Disposable {
    let closure: () -> Void
    
    func disposed(by disposeBag: DisposeBag) {
        disposeBag.disposables.append(self)
    }
}
