//
//  AppDelegate.swift
//  ForkTest
//
//  Created by Wilmar on 10/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let restaurantsViewController = RestaurantsViewController(viewModel: RestaurantsViewModel(restaurantsModel: RestaurantsModel(worker: RestaurantWorker())))
        let navigationController = UINavigationController(rootViewController: restaurantsViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

