//
//  TaskScheduler.swift
//  Contacts
//
//  Created by Macbook on 07.11.2022.
//

import Foundation

struct RefreshManager {
    
    func deleteContacts() {
        let coreDataStack = CoreDataStack()
        let coreDataService = CoreDataService(coreDataStack: coreDataStack)
        coreDataService.deleteContacts()
    }
}
