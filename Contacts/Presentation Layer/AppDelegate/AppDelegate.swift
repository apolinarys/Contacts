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
        
        return true
    }
    
    private func setupTaskScheduler() {
        BGTaskScheduler.shared.register(
          forTaskWithIdentifier: AppConstants.backgroundTaskIdentifier,
          using: nil) { task in
            self.refresh() // 1
            task.setTaskCompleted(success: true)
            self.scheduleAppRefresh()
        }

        scheduleAppRefresh()
    }
    
    private func refresh() {
        let refreshManager = RefreshManager()
        refreshManager.deleteContacts()
        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.DateKey)
        Logger.shared.message("refresh occurred")
    }
    
    private func scheduleAppRefresh() {
      let request = BGAppRefreshTaskRequest(
        identifier: AppConstants.backgroundTaskIdentifier)
      request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 60)
        if UserDefaults.standard.object(forKey: UserDefaultsKeys.DateKey) == nil {
          do {
            try BGTaskScheduler.shared.submit(request)
              Logger.shared.message("background refresh scheduled")
          } catch {
              Logger.shared.message("Couldn't schedule app refresh \(error.localizedDescription)")
          }
        }
    }
}
