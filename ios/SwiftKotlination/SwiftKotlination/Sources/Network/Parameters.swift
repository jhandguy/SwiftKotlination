import Foundation

enum Parameters {
    case body(Data)
    case url([String: String?])
    case none
}
