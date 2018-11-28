package fr.jhandguy.swiftkotlination.observer

import org.junit.Before
import org.junit.Test

class DisposeBagUnitTest {

    lateinit var sut: DisposeBag

    @Before
    fun before() {
        sut = DisposeBag()
    }

    @Test
    fun `disposable is disposed correctly`() {
        var isDisposed = false
        val disposable = Disposable {
            isDisposed = true
        }

        disposable.disposedBy(sut)

        assert(sut.disposables.isNotEmpty())

        sut.dispose()

        assert(isDisposed)
        assert(sut.disposables.isEmpty())
    }
}