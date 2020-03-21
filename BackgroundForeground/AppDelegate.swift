import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        print("\(Thread.current)")
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Track: Foreground \(Thread.current)")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            print("Track: Enter Foreground DispatchQueue \(Thread.current)")
            for index in 1...10 {
                sleep(1)
                print("Track: After Foreground DispatchQueue \(index)")
            }
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

        var backgroundTaskID: UIBackgroundTaskIdentifier?
        backgroundTaskID = UIApplication.shared.beginBackgroundTask (withName: "Finish Background Tasks") {
            backgroundTaskID = self.endBackgroundTask(backgroundTaskID: backgroundTaskID)
        }

        guard backgroundTaskID?.rawValue != UIBackgroundTaskIdentifier.invalid.rawValue else { return }

        print("Track: Background \(Thread.current)")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            print("Track: Enter Background DispatchQueue \(Thread.current)")
            for index in 1...10 {
                sleep(1)
                print("Track: After Background DispatchQueue \(index)")
            }

            backgroundTaskID = self.endBackgroundTask(backgroundTaskID: backgroundTaskID)
         }
    }

    func endBackgroundTask(backgroundTaskID: UIBackgroundTaskIdentifier?) -> UIBackgroundTaskIdentifier {
        if let backgroundTaskID = backgroundTaskID, backgroundTaskID != UIBackgroundTaskIdentifier.invalid {
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
        }
        return UIBackgroundTaskIdentifier.invalid
    }
}
