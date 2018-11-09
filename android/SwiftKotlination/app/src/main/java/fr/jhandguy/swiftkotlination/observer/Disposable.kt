package fr.jhandguy.swiftkotlination.observer

data class Disposable(val block: () -> Unit) {
    fun disposedBy(disposeBag: DisposeBag) {
        disposeBag.disposables.add(this)
    }
}