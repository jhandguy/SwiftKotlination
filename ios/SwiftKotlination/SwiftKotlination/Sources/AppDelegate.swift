import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    internal var coordinator: CoordinatorProtocol!
    
    override init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = Coordinator(window: window!)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        coordinator.start()
        return true
    }
}

