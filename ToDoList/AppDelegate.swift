//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 02.09.23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if let user = Auth.auth().currentUser {
            // User is already authenticated; navigate to the appropriate view controller.
            // Example:
            let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            let navigationController = UINavigationController(rootViewController: mainViewController)
            window?.rootViewController = navigationController
        } else {
            // User is not authenticated; navigate to the login/signup view controller.
            // Example:
            let launchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
            let navigationController = UINavigationController(rootViewController: launchViewController)
            window?.rootViewController = navigationController
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

