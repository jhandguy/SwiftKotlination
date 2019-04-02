import XCTest

enum Predicate {
    case exists, doesNotExist
    case isHittable, isNotHittable

    var format: String {
        switch self {
        case .exists:
            return "exists == true"
        case .doesNotExist:
            return "exists == false"
        case .isHittable:
            return "isHittable == true"
        case .isNotHittable:
            return "isHittable == false"
        }
    }
}
