import XCTest

enum Predicate {
    case contains(String), doesNotContain(String)
    case exists, doesNotExist
    case has(Int, XCUIElement.ElementType), doesNotHave(Int, XCUIElement.ElementType)
    case isHittable, isNotHittable

    var format: String {
        switch self {
        case .contains(let label):
            return "label == '\(label)'"
        case .doesNotContain(let label):
            return "label != '\(label)'"
        case .exists:
            return "exists == true"
        case .doesNotExist:
            return "exists == false"
        case let .has(count, element):
            return "\(element.name)s.count == \(count)"
        case let .doesNotHave(count, element):
            return "\(element.name)s.count != \(count)"
        case .isHittable:
            return "isHittable == true"
        case .isNotHittable:
            return "isHittable == false"
        }
    }
}
