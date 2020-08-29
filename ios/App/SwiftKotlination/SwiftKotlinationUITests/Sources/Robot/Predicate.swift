import XCTest

enum Predicate {
    case contains(String), doesNotContain(String)
    case exists, doesNotExist
    case `is`(String), isNot(String)
    case isLike(String), isNotLike(String)
    case isHittable, isNotHittable
    case isEnabled, isNotEnabled
    case isSelected, isNotSelected
    case has(Int, XCUIElement.ElementType)
    case doesNotHave(Int, XCUIElement.ElementType)

    var format: String {
        switch self {
        case .contains(let label):
            return "label == \"\(label.replacingOccurrences(of: "\"", with: "\\\""))\""
        case .doesNotContain(let label):
            return "label != \"\(label.replacingOccurrences(of: "\"", with: "\\\""))\""
        case .exists:
            return "exists == true"
        case .doesNotExist:
            return "exists == false"
        case .is(let value):
            return "value == \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
        case .isNot(let value):
            return "value != \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
        case .isLike(let value):
            return "value LIKE[cd] \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
        case .isNotLike(let value):
            return "value NOT LIKE[cd] \"\(value.replacingOccurrences(of: "\"", with: "\\\""))\""
        case .isHittable:
            return "isHittable == true"
        case .isNotHittable:
            return "isHittable == false"
        case .isEnabled:
            return "isEnabled == true"
        case .isNotEnabled:
            return "isEnabled == false"
        case .isSelected:
            return "isSelected == true"
        case .isNotSelected:
            return "isSelected == false"
        case let .has(count, element):
            return "\(element.name)s.count == \(count)"
        case let .doesNotHave(count, element):
            return "\(element.name)s.count != \(count)"
        }
    }
}
