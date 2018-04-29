import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else {
            return false
        }
        
        let viewController = UIViewController()
        window.rootViewController = viewController
        window.isHidden = false
        return true
    }
}

