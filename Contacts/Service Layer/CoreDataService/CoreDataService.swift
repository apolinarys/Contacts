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
}

struct CoreDataService: ICoreDataService {
    
    let coreDataStack: ICoreDataStack
    
    func getContacts() -> [Contact] {
        let fetchRequest = DBContact.fetchRequest()
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
