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
        let coreDataStack = CoreDataStack()
        let coreDataService = CoreDataService(coreDataStack: coreDataStack)
        coreDataService.deleteContacts()
        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.DateKey)
        Logger.shared.message("refresh occurred")
    }
    
    func scheduleAppRefresh() {
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
