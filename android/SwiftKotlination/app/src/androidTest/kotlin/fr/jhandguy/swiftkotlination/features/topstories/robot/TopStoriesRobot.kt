package fr.jhandguy.swiftkotlination.features.topstories.robot

import android.app.Activity
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.action.ViewActions.swipeDown
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.espresso.matcher.ViewMatchers.withParent
import androidx.test.espresso.matcher.ViewMatchers.withText
import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.robot.StoryRobot
import fr.jhandguy.swiftkotlination.matchers.RecyclerViewMatcher
import fr.jhandguy.swiftkotlination.matchers.RecyclerViewMatcher.Companion.childOfParent
import fr.jhandguy.swiftkotlination.robot.Robot
import org.hamcrest.CoreMatchers.allOf

class TopStoriesRobot<T : Activity>(activityTestRule: ActivityTestRule<T>) : Robot<T>(activityTestRule) {

    fun checkTopStoriesCount(count: Int): TopStoriesRobot<T> {
        onView(withId(R.id.top_stories_list))
            .check(matches(RecyclerViewMatcher.withItemCount(count)))

        return this
    }

    fun forEachTopStories(indexes: List<Int>, completion: (TopStoriesRobot<T>, Int) -> Unit): TopStoriesRobot<T> {
        indexes.forEach { index ->
            completion(this, index)
        }

        return this
    }

    fun checkTopStoryTitle(title: String, index: Int): TopStoriesRobot<T> {
        onView(
            allOf(
                withParent(childOfParent(withId(R.id.top_stories_list), index)),
                withId(R.id.top_stories_item_title)
            )
        )
            .check(matches(withText(title)))

        return this
    }

    fun checkTopStoryByline(byline: String, index: Int): TopStoriesRobot<T> {
        onView(
            allOf(
                withParent(childOfParent(withId(R.id.top_stories_list), index)),
                withId(R.id.top_stories_item_byline)
            )
        )
            .check(matches(withText(byline)))

        return this
    }

    fun openStory(index: Int): StoryRobot<T> {
        onView(childOfParent(withId(R.id.top_stories_list), index))
            .perform(click())

        return StoryRobot(activityRule)
    }

    fun refreshTopStories(): TopStoriesRobot<T> {
        onView(withId(R.id.top_stories_list))
            .perform(swipeDown())

        return this
    }
}
