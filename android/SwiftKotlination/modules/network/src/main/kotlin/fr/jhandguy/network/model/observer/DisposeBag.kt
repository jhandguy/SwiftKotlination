package fr.jhandguy.network.model.observer

class DisposeBag(var disposables: MutableList<Disposable> = ArrayList()) {
    fun dispose() {
        disposables.forEach { it.block() }
        disposables = ArrayList()
    }
}
