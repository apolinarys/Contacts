//
//  CoreDataService.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation

protocol ICoreDataService {
    func getContacts() -> [Contact]
    func saveContacts(contacts: [Contact])
    func deleteContacts()
}

struct CoreDataService: ICoreDataService {
    
    let coreDataStack: ICoreDataStack
    
    func getContacts() -> [Contact] {
        let fetchRequest = DBContact.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(DBContact.name), ascending: true)]
        let contacts = coreDataStack.fetch(fetchRequest: fetchRequest)
        var output: [Contact] = []
        contacts?.forEach {
            if let name = $0.name, let phoneNumber = $0.phoneNumber {
                output.append(Contact(name: name, phoneNumber: phoneNumber, skills: getSkills(contact: $0)))
            }
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
