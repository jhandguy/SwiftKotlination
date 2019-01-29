extension Request {

    var absoluteUrl: String {
        guard let query = parameters.query else {
            return url
        }

        return "\(url)?\(query)"
    }
}
