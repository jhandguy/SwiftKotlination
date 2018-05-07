import ObjectMapper

struct Story: ImmutableMappable {
    let section: String
    let subsection: String
    let title: String
    let abstract: String
    let url: String
    let byline: String
    
    init(map: Map) throws {
        section         = try map.value("section")
        subsection      = try map.value("subsection")
        title           = try map.value("title")
        abstract        = try map.value("abstract")
        url             = try map.value("url")
        byline          = try map.value("byline")
    }
    
    func mapping(map: Map) {
        section         >>> map["section"]
        subsection      >>> map["subsection"]
        title           >>> map["title"]
        abstract        >>> map["abstract"]
        url             >>> map["url"]
        byline          >>> map["byline"]
    }
}
