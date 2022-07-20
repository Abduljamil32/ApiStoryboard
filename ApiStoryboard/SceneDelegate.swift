import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        callHomeController()
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    func callHomeController() {
        
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let nc = UINavigationController(rootViewController: vc)
        
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        self.window?.rootViewController = nc
        self.window?.makeKeyAndVisible()
    }
}

