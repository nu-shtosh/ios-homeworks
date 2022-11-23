//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Илья Дубенский on 21.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = makeTabBarController()
    }
}

extension SceneDelegate {
    private func makeTabBarController() -> UITabBarController {
        let feedVC = FeedViewController()
        let profileVC = ProfileViewController()

        let feedNavBarVC = UINavigationController(rootViewController: feedVC)
        let profileNavBarVC = UINavigationController(rootViewController: profileVC)

        setSettings(forViewControllers: feedVC, profileVC)

        let rootTabBarController = UITabBarController()
        rootTabBarController.viewControllers = [feedNavBarVC, profileNavBarVC]
        
        setSettings(forTabBarController: rootTabBarController)

        return rootTabBarController
    }

    private func setSettings(forTabBarController tabBarController: UITabBarController) {
        tabBarController.tabBar.backgroundColor = .darkGray
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.tintColor = .white
    }

    private func setSettings(forViewControllers viewControllers: UIViewController...) {
        viewControllers.forEach{ viewController in
            if viewController is ProfileViewController {
                viewController.tabBarItem.image = UIImage(systemName: "person.circle")
                viewController.tabBarItem.title = "Profile"
            } else if viewController is FeedViewController {
                viewController.tabBarItem.image = UIImage(systemName: "list.bullet.circle")
                viewController.tabBarItem.title = "Feed"
            }
        }
    }
}
