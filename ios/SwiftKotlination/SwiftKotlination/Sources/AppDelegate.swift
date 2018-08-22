import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    internal var coordinator: CoordinatorProtocol!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        var apiClient = APIClient()
        if
            let encodedSessionMock = ProcessInfo.processInfo.environment[URLSessionMock.identifier],
            let sessionMock = URLSessionMock.decode(from: encodedSessionMock) {

                apiClient = APIClient(session: sessionMock)
        }
        
        coordinator = Coordinator(window: window!, apiClient: apiClient)
        
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
