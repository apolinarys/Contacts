//
//  CoreDataService.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation

/// Сервис работы с хранилищем.
protocol ICoreDataService {
    
    // MARK: - Methods
    
    /// Возвращает контакты.
    func getContacts() -> [Contact]?
    
    /// Сохраняет контакты.
    func saveContacts(contacts: [Contact])
    
    /// Удаляет контакты.
    func deleteContacts()
}

struct CoreDataService: ICoreDataService {
    
    // MARK: - Dependencies
    
    let coreDataStack: ICoreDataStack
    
    // MARK: - ICoreDataService
    
    func getContacts() -> [Contact]? {
        let fetchRequest = DBContact.fetchRequest()
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(DBContact.name), ascending: true)
        ]
        
        let contacts = coreDataStack.fetch(fetchRequest: fetchRequest)
        
        var output: [Contact] = []
        
        contacts?.forEach {
            if let name = $0.name, let phoneNumber = $0.phoneNumber {
                output.append(
                    Contact(name: name, phoneNumber: phoneNumber, skills: getSkills(contact: $0))
                )
            }
        }
        
        if output.isEmpty {
            return nil
        }
        
        return output
    }
    
    func saveContacts(contacts: [Contact]) {
        contacts.forEach { contact in
            coreDataStack.performSave { context in
                let dbContact = DBContact(context: context)
                dbContact.name = contact.name
                dbContact.phoneNumber = contact.phoneNumber
                contact.skills.forEach {
                    let skill = Skill(context: context)
                    skill.skill = $0
                    dbContact.addToSkills(skill)
                }
            }
        }
    }
    
    func deleteContacts() {
        let fetchRequest = DBContact.fetchRequest()
        guard let contacts = coreDataStack.fetch(fetchRequest: fetchRequest) else { return }
        coreDataStack.performSave { context in
            contacts.forEach {
                context.delete($0)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func getSkills(contact: DBContact) -> [String] {
        let fetchRequest = Skill.fetchRequest()
        let skills = coreDataStack.fetch(fetchRequest: fetchRequest)
        var output: [String] = []
        output += skills?.compactMap {
            if $0.contact == contact {
                return $0.skill
            }
            return nil
        } ?? []
        return output
    }
}
