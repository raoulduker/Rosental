//
//  MainCoordinator.swift
//  Rosental
//
//  Created by Артем Петрюк on 02.09.2024.
//

import UIKit

@MainActor
class AppCoordinator {
    
    let window: UIWindow
    var navigationController: UINavigationController?
    var apiResponse: ApiResponse?
    
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
  
        // TODO: Implement check if user is authenticated
        let isAuthenticated = false
        if isAuthenticated {
            showMainFlow()
        } else {
            showWelcomeScreen()
        }
    }
    
    private func showWelcomeScreen() {
            let welcomeVC = WelcomeVC()
            welcomeVC.coordinator = self
            let navigationController = UINavigationController(rootViewController: welcomeVC)
            self.navigationController = navigationController
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    
    func showLoginScreen() {
            let loginVC = LoginVC()
            loginVC.coordinator = self
            navigationController?.pushViewController(loginVC, animated: true)
        }

    func showMainFlow() {
            Task {
                do {
                    apiResponse = try await NetworkManager.loadApiResponse()
                    let tabBarController = createTabBarController()
                    window.rootViewController = tabBarController
                    window.makeKeyAndVisible()
                } catch {
                    // TODO: Handle error (e.g., show an error screen)
                }
            }
        }
    
    
    private func createTabBarController() -> UITabBarController {
        guard let dashboard = apiResponse?.customerDashboard else { return UITabBarController() }
        let tabBarController = UITabBarController()
        var viewControllers: [UIViewController] = []
        
        for navbarItem in dashboard.navbar {
            let viewController = createViewController(for : navbarItem)
            let image = getNavBarImage(for: navbarItem)
            let tabBarItem = UITabBarItem(title: navbarItem.name, image: image, tag: 0)
            viewController.tabBarItem = tabBarItem
            viewControllers.append(viewController)
        }
        
        tabBarController.viewControllers = viewControllers
        return tabBarController
    }
    
    private func getNavBarImage(for navbarItem: NavbarItem) -> UIImage? {
        switch navbarItem.action {
        case "main":
            UIImage(systemName: "key.horizontal")
        case "treatment":
            UIImage(systemName: "square.stack")
        case "service":
            UIImage(systemName: "star")
        case "chat":
            UIImage(systemName: "message")
        case "contact":
            UIImage(systemName: "book.closed")
        default:
            // TODO: What if this happens?
            // ZANAVESKI pokazhem
            UIImage(systemName: "roman.shade.open")
        }
    }
    
    private func createViewController(for navbarItem: NavbarItem) -> UIViewController {
        switch navbarItem.action {
        case "main":
            let dashboardVC = DashboardVC()
            dashboardVC.apiResponse = apiResponse
            return dashboardVC
        case "treatment":
            return TreatmentVC()
        case "service":
           return ServiceVC()
        case "chat":
            return ChatVC()
        case "contact":
            return ContactVC()
        default:
            // TODO: What if this happens?
            return UIViewController()
        }
    }
}
