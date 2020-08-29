import Foundation

enum Parameters {
    case body(Data)
    case url([String: String?])
    case none

    var query: String? {
        switch self {
        case let .url(url):
            guard !url.isEmpty else {
                return nil
            }

            return url
                .map { key, value in
                    guard let value = value else {
                        return key
                    }
                    return "\(key)=\(value)"
                }.joined(separator: "&")
        default:
            return nil
        }
    }
}
