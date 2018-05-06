import ObjectMapper

struct Story: Mappable {
    var section: String
    var subsection: String
    var title: String
    var abstract: String
    var url: String
    var byline: String
    
    init?(map: Map) {
        guard
            let section         = map.JSON["section"] as? String,
            let subsection      = map.JSON["subsection"] as? String,
            let title           = map.JSON["title"] as? String,
            let abstract        = map.JSON["abstract"] as? String,
            let url             = map.JSON["url"] as? String,
            let byline          = map.JSON["byline"] as? String else {
                
                return nil
        }
        
        self.section = section
        self.subsection = subsection
        self.title = title
        self.abstract = abstract
        self.url = url
        self.byline = byline
    }
    
    mutating func mapping(map: Map) {
        section         <- map["section"]
        subsection      <- map["subsection"]
        title           <- map["title"]
        abstract        <- map["abstract"]
        url             <- map["url"]
        byline          <- map["byline"]
    }
}
