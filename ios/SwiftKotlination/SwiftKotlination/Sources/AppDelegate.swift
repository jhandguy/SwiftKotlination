import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    internal var coordinator: CoordinatorProtocol!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if
            let encodedAPIClientMock = ProcessInfo.processInfo.environment[APIClientMock.key],
            let apiClientMock = APIClientMock.decode(from: encodedAPIClientMock) {
            
                coordinator = Coordinator(window: window!, apiClient: apiClientMock)
        } else {
            coordinator = Coordinator(window: window!, apiClient: APIClient())
        }
        
        guard
            let encodedCoordinatorStub = ProcessInfo.processInfo.environment[CoordinatorStub.key],
            let coordinatorStub = CoordinatorStub.decode(from: encodedCoordinatorStub) else {
                coordinator.start()
                return true
        }
        
        
        switch coordinatorStub {
        case .start:
            coordinator.start()
        case let .open(story):
            coordinator.open(story)
        }
        
        return true
    }
}
