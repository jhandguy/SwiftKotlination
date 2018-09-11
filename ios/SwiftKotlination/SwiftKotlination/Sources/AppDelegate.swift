import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Internal Properties

    var factory: CoordinatorFactory!

    // MARK: - Private Properties

    private lazy var coordinator: CoordinatorProtocol = factory.makeCoordinator(for: UIWindow(frame: UIScreen.main.bounds))

    // MARK: - Lifecycle Methods

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        var apiClient = APIClient()
        if
            let encodedSessionMock = ProcessInfo.processInfo.environment[URLSessionMock.identifier],
            let sessionMock = URLSessionMock.decode(from: encodedSessionMock) {

            apiClient = APIClient(session: sessionMock)
        }

        factory = Factory(apiClient: apiClient)
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard
            let encodedCoordinatorStub = ProcessInfo.processInfo.environment[CoordinatorStub.identifier],
            let coordinatorStub = CoordinatorStub.decode(from: encodedCoordinatorStub) else {

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
}
