import Foundation

extension AnimationStub: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if let areAnimationsEnabled = try? values.decode(Bool.self, forKey: .areAnimationsEnabled) {
            self = areAnimationsEnabled ? .enableAnimations : .disableAnimations
            return
        }

        self = .disableAnimations
    }
}
