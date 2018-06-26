package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import com.nhaarman.mockito_kotlin.whenever
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import io.reactivex.Observable
import org.junit.Assert.assertEquals
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.Mockito.verify
import org.mockito.junit.MockitoJUnitRunner
import java.util.*

@RunWith(MockitoJUnitRunner::class)
class TopStoriesViewModelUnitTest {
    @Mock
    private lateinit var repository: TopStoriesRepository

    @Test
    fun topStories_areCorrect() {
        val stories = Collections.singletonList(Story(title = "Story Headline"))
        whenever(repository.topStories).thenReturn(Observable.just(stories))

        TopStoriesViewModel(repository)
                .topStories
                .subscribe {
                    assertEquals(it, stories)
                }

        verify(repository).topStories
    }
}
