import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Internal Properties

    var coordinator: CoordinatorProtocol!

    // MARK: - Lifecycle Methods

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        if let animationStub = decode(AnimationStub.self) {
            UIView.setAnimationsEnabled(animationStub.areAnimationsEnabled)
        }

        let session: URLSessionProtocol = decode(URLSessionMock.self) ?? URLSession(configuration: .default)
        let networkManager = NetworkManager(session: session)
        let factory = DependencyManager(networkManager: networkManager)
        let window = UIWindow(frame: UIScreen.main.bounds)

        coordinator = Coordinator(factory: factory, window: window)

        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let coordinatorStub = decode(CoordinatorStub.self) else {
            coordinator.start()
            return true
        }

        switch coordinatorStub {
        case .start:
            coordinator.start()
        case .openStory(let story):
            coordinator.open(story)
        case .openUrl(let url):
            coordinator.open(url)
        }

        return true
    }

    // Private Methods

    private func decode<T: Identifiable & Decodable>(_: T.Type) -> T? {
        guard
            let processInfo = ProcessInfo.processInfo.environment[T.identifier],
            let codable = T.decode(from: processInfo) else {
                return nil
        }

        return codable
    }
}
