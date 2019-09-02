package fr.jhandguy.swiftkotlination.matchers

import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import androidx.test.espresso.matcher.BoundedMatcher
import org.hamcrest.Description
import org.hamcrest.Matcher
import org.hamcrest.TypeSafeMatcher

class RecyclerViewMatcher {
    companion object {
        fun withItemCount(count: Int): Matcher<View> {
            return object : BoundedMatcher<View, RecyclerView>(RecyclerView::class.java) {
                override fun describeTo(description: Description?) {
                    description?.appendText("RecyclerView with item count: $count")
                }

                override fun matchesSafely(item: RecyclerView?): Boolean {
                    return item?.adapter?.itemCount == count
                }
            }
        }

        fun childOfParent(parentMatcher: Matcher<View>, childPosition: Int): Matcher<View> {
            return object : TypeSafeMatcher<View>() {

                override fun describeTo(description: Description) {
                    description.appendText("with $childPosition child view of type parentMatcher")
                }

                override fun matchesSafely(view: View): Boolean {
                    if (view.parent !is ViewGroup) {
                        return parentMatcher.matches(view.parent)
                    }

                    val group = view.parent as ViewGroup
                    return parentMatcher.matches(view.parent) && group.getChildAt(childPosition) == view
                }
            }
        }
    }
}
