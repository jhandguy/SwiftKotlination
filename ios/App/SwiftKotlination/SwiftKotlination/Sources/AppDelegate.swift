import ExtensionKit
import NetworkKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: CoordinatorProtocol!

    func application(
        _: UIApplication,
        willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        if let animationStub = ProcessInfo.processInfo.decode(AnimationStub.self) {
            UIView.setAnimationsEnabled(animationStub.areAnimationsEnabled)
        }

        let session: URLSessionProtocol = ProcessInfo.processInfo.decode(URLSessionMock.self) ?? URLSession(configuration: .default)
        let networkManager = NetworkManager(session: session)
        let factory = DependencyManager(networkManager: networkManager)
        let window = UIWindow(frame: UIScreen.main.bounds)

        coordinator = Coordinator(factory: factory, window: window)

        return true
    }

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        guard let coordinatorStub = ProcessInfo.processInfo.decode(CoordinatorStub.self) else {
            coordinator.start()
            return true
        }

        switch coordinatorStub {
        case .start:
            coordinator.start()
        case let .openStory(story):
            coordinator.open(story)
        case let .openUrl(url):
            coordinator.open(url)
        }

        return true
    }
}
