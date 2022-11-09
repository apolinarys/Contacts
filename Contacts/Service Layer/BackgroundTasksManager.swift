//
//  BackgroundTasksManager.swift
//  Contacts
//
//  Created by Macbook on 09.11.2022.
//

import Foundation
import BackgroundTasks

/// Менеджер установки бекграунд задач.
protocol IBackgroundsTasksManager {
    
    // MARK: - Methods
    
    /// Устанавливает задачу.
    func setupTaskScheduler()
}

struct BackgroundTasksManager: IBackgroundsTasksManager {
    
    // MARK: - Dependencies
    
    let refreshManager: RefreshManager
    
    // MARK: - IBackgroundsTasksManager
    
    func setupTaskScheduler() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.isCompetedKey)
        BGTaskScheduler.shared.register(
          forTaskWithIdentifier: AppConstants.backgroundTaskIdentifier,
          using: nil,
          launchHandler: { task in
            self.refresh()
            task.setTaskCompleted(success: true)
            self.scheduleAppRefresh()
        })
        
        scheduleAppRefresh()
    }
    
    // MARK: - Private methods
    
    private func refresh() {
        refreshManager.deleteContacts()
        Logger.shared.message("refresh occurred")
    }
    
    private func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(
            identifier: AppConstants.backgroundTaskIdentifier
        )
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 60)
        
        if UserDefaults.standard.object(forKey: UserDefaultsKeys.isCompetedKey) == nil {
            do {
                try BGTaskScheduler.shared.submit(request)
                UserDefaults.standard.set(1, forKey: UserDefaultsKeys.isCompetedKey)
                Logger.shared.message("background refresh scheduled")
            } catch {
                Logger.shared.message("Couldn't schedule app refresh \(error.localizedDescription)")
            }
        }
    }
}
