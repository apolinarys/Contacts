//
//  CoreDataStack.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import CoreData

protocol ICoreDataStack {
    func getContext() -> NSManagedObjectContext
    func fetch<T>(fetchRequest: NSFetchRequest<T>) -> [T]?
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void)
}

private extension String {
    static let coreDataStackContainerName = "CoreDataModel"
}

final class CoreDataStack: ICoreDataStack {
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: String.coreDataStackContainerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                Logger.shared.message(error.localizedDescription)
            }
        }
        return container
    }()
    
    func getContext() -> NSManagedObjectContext {
        container.viewContext
    }
    
    func fetch<T>(fetchRequest: NSFetchRequest<T>) -> [T]? {
        try? container.viewContext.fetch(fetchRequest)
    }
    
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let context = container.newBackgroundContext()
        context.perform { [weak self] in
            block(context)
            if context.hasChanges {
                do {
                    try self?.performSave(in: context)
                } catch {
                    Logger.shared.message(error.localizedDescription)
                }
            }
        }
    }
    
    private func performSave(in context: NSManagedObjectContext) throws {
        try context.save()
        if let parent = context.parent {
            try performSave(in: parent)
        }
    }
}