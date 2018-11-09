package fr.jhandguy.swiftkotlination.observer

class DisposeBag(var disposables: MutableList<Disposable> = ArrayList()) {
    fun dispose() {
        disposables.forEach { it.block }
        disposables = ArrayList()
    }
}