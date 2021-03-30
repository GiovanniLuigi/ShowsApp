//
//  SceneDelegate.swift
//  ShowsApp
//
//  Created by Giovanni Luidi Bruno on 27/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        let navigator = UIKitNavigator(navigationController: navigationController)
        
        appCoordinator = AppCoordinator(navigator: navigator, parent: nil)
        appCoordinator?.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .dark
        }
//        setupFonts()
    }
    
    private func setupFonts() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.title1]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.largeTitle]
    }
    
}
