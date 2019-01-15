package fr.jhandguy.swiftkotlination

import fr.jhandguy.swiftkotlination.factory.DependencyManager
import fr.jhandguy.swiftkotlination.network.NetworkManager
import java.io.InputStream
import java.net.HttpURLConnection
import java.net.URL
import java.net.URLConnection
import java.net.URLStreamHandler

open class AppMock : App() {

    override fun onCreate() {
        super.onCreate()

        val json = "{\"status\":\"OK\",\"copyright\":\"Copyright (c) 2018 The New York Times Company. All Rights Reserved.\",\"section\":\"home\",\"last_updated\":\"2018-11-20T04:17:12-05:00\",\"num_results\":40,\"results\":[{\"section\":\"Business\",\"subsection\":\"\",\"title\":\"Tech Stocks Lead Slump That Erases November\\u2019s Gains\",\"abstract\":\"The sell-off in tech stocks continued, as Apple, Amazon, Facebook and Google all dropped.\",\"url\":\"https:\\/\\/www.nytimes.com\\/2018\\/11\\/19\\/business\\/tech-stocks-markets-slump.html\",\"byline\":\"By MATT PHILLIPS\",\"item_type\":\"Article\",\"updated_date\":\"2018-11-19T23:13:11-05:00\",\"created_date\":\"2018-11-19T13:51:39-05:00\",\"published_date\":\"2018-11-19T13:51:39-05:00\",\"material_type_facet\":\"\",\"kicker\":\"\",\"des_facet\":[\"Stocks and Bonds\",\"Standard & Poor's 500-Stock Index\"],\"org_facet\":[\"Apple Inc\",\"Amazon.com Inc\",\"Facebook Inc\",\"Alphabet Inc\"],\"per_facet\":[],\"geo_facet\":[],\"multimedia\":[{\"url\":\"https:\\/\\/static01.nyt.com\\/images\\/2018\\/11\\/20\\/business\\/20Stocks\\/20Stocks-thumbStandard.png\",\"format\":\"Standard Thumbnail\",\"height\":75,\"width\":75,\"type\":\"image\",\"subtype\":\"photo\",\"caption\":\"\",\"copyright\":\"\"},{\"url\":\"https:\\/\\/static01.nyt.com\\/images\\/2018\\/11\\/20\\/business\\/20Stocks\\/20Stocks-thumbLarge.png\",\"format\":\"thumbLarge\",\"height\":150,\"width\":150,\"type\":\"image\",\"subtype\":\"photo\",\"caption\":\"\",\"copyright\":\"\"},{\"url\":\"https:\\/\\/static01.nyt.com\\/images\\/2018\\/11\\/20\\/business\\/20Stocks\\/20Stocks-articleInline.png\",\"format\":\"Normal\",\"height\":128,\"width\":190,\"type\":\"image\",\"subtype\":\"photo\",\"caption\":\"\",\"copyright\":\"\"},{\"url\":\"https:\\/\\/static01.nyt.com\\/images\\/2018\\/11\\/20\\/business\\/20Stocks\\/20Stocks-mediumThreeByTwo210.png\",\"format\":\"mediumThreeByTwo210\",\"height\":140,\"width\":210,\"type\":\"image\",\"subtype\":\"photo\",\"caption\":\"\",\"copyright\":\"\"},{\"url\":\"https:\\/\\/static01.nyt.com\\/images\\/2018\\/11\\/20\\/business\\/20Stocks\\/20Stocks-superJumbo.png\",\"format\":\"superJumbo\",\"height\":1089,\"width\":1621,\"type\":\"image\",\"subtype\":\"photo\",\"caption\":\"\",\"copyright\":\"\"}],\"short_url\":\"https:\\/\\/nyti.ms\\/2DyWlF0\"}]}"
        val handler = object : URLStreamHandler() {
            override fun openConnection(url: URL): URLConnection = object : HttpURLConnection(url) {
                override fun usingProxy(): Boolean = false
                override fun getInputStream(): InputStream = json.byteInputStream()
                override fun connect() {}
                override fun disconnect() {}
                override fun getResponseCode(): Int = 200
            }
        }
        factory = DependencyManager(NetworkManager(handler))
    }
}