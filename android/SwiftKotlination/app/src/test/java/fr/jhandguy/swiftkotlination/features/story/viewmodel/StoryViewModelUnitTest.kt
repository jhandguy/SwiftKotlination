package fr.jhandguy.swiftkotlination.features.story.viewmodel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepository
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import io.reactivex.Observable
import junit.framework.Assert
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.koin.dsl.module.module
import org.koin.standalone.StandAloneContext.closeKoin
import org.koin.standalone.StandAloneContext.startKoin
import org.koin.standalone.inject
import org.koin.test.KoinTest
import org.koin.test.declare

class StoryViewModelUnitTest: KoinTest {

    val viewModel: StoryViewModel by inject()

    @Before
    fun before(){
        startKoin(listOf(
                module {
                    factory { StoryViewModel(get()) }
                }
        ))
    }

    @Test
    fun `story is fetched correctly`() {
        val story = Story("section", "subsection", "title", "abstract", "url", "byline")

        declare {
            factory { StoryRepositoryMock(Observable.just(story)) as StoryRepository }
        }

        viewModel
                .story
                .subscribe {
                    Assert.assertEquals(it, story)
                }
    }

    @After
    fun after(){
        closeKoin()
    }

}