extension AnimationStub: Encodable {

    // MARK: - Internal Methods

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .enableAnimations:
            try container.encode(true, forKey: .areAnimationsEnabled)
        case .disableAnimations:
            try container.encode(false, forKey: .areAnimationsEnabled)
        }
    }
}
