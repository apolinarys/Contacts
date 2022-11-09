//
//  AppDelegate.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import UIKit
import BackgroundTasks

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = ViewControllersFactory().createContactsModule()
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        
        window?.makeKeyAndVisible()
        
        setupBackgroundTask()
        
        return true
    }
    
    private func setupBackgroundTask() {
        let refreshManager = RefreshManager()
        let backgroundTasksManager = BackgroundTasksManager(refreshManager: refreshManager)
        backgroundTasksManager.setupTaskScheduler()
    }
}
