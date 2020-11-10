//
//  AppDelegate.swift
//  The Books
//
//  Created by Luis Gustavo Oliveira Silva on 04/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let rootViewController = UINavigationController(rootViewController: SearchViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
