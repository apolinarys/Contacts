//
//  AppDelegate.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        return formatter
      }()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        BGTaskScheduler.shared.register(
          forTaskWithIdentifier: AppConstants.backgroundTaskIdentifier,
          using: nil) { task in
            self.refresh() // 1
            task.setTaskCompleted(success: true) // 2
            self.scheduleAppRefresh() // 3
        }

        scheduleAppRefresh()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let viewControllersFactory = ViewControllersFactory()
        let initialVC = viewControllersFactory.createContactsModule()
        navigationController.viewControllers = [initialVC]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func refresh() {
      let formattedDate = Self.dateFormatter.string(from: Date())
      UserDefaults.standard.set(
        formattedDate,
        forKey: UserDefaultsKeys.lastRefreshDateKey)
      print("refresh occurred")
    }
    
    func scheduleAppRefresh() {
      let request = BGAppRefreshTaskRequest(
        identifier: AppConstants.backgroundTaskIdentifier)
      request.earliestBeginDate = Date(timeIntervalSinceNow: 10)
      do {
        try BGTaskScheduler.shared.submit(request)
        print("background refresh scheduled")
      } catch {
        print("Couldn't schedule app refresh \(error.localizedDescription)")
      }
    }

}
