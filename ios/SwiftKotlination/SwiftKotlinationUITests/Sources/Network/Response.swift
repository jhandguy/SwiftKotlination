struct Response: Codable {
    var file: File?
    var error: NetworkError?
    var dataTask: URLSessionDataTaskMock
    
    init(_ file: File? = nil, error: NetworkError? = nil, dataTask: URLSessionDataTaskMock = URLSessionDataTaskMock()) {
        self.file = file
        self.error = error
        self.dataTask = dataTask
    }
}
