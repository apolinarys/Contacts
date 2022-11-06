//
//  ContactsPresenter.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation
import UserNotifications

protocol IContactsPresenter {
    func onViewDidLoad()
}

struct ContactsPresenter: IContactsPresenter {
    
    let requestSender: IRequestSender
    let coreDataService: ICoreDataService
    let view: IContactsView
    
    func onViewDidLoad() {
        let savedContacts = coreDataService.getContacts()
        print(savedContacts)
        if savedContacts.isEmpty {
            requestSender.send(requestConfig: RequestsFactory.contactsConfig()) { result in
                switch result {
                case .success(let contacts):
                    DispatchQueue.main.async {
                        view.contactsConfig(contacts: contacts)
                    }
                    saveContacts(contacts: contacts)
                case .failure(let error):
                    Logger.shared.message(error.localizedDescription)
                }
            }
        } else {
            view.contactsConfig(contacts: savedContacts)
        }
    }
    
    private func saveContacts(contacts: [Contact]) {
        print(#function)
        coreDataService.saveContacts(contacts: contacts)
    }
}
