enum AnimationStub: Identifiable {
    case enableAnimations, disableAnimations

    var areAnimationsEnabled: Bool {
        switch self {
        case .enableAnimations:
            return true
        case .disableAnimations:
            return false
        }
    }
}

extension AnimationStub {
    enum CodingKeys: String, CodingKey { case areAnimationsEnabled }
}
