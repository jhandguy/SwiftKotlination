package fr.jhandguy.swiftkotlination.observer

import kotlin.test.BeforeTest
import kotlin.test.Test

class DisposeBagUnitTest {

    lateinit var sut: DisposeBag

    @BeforeTest
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
