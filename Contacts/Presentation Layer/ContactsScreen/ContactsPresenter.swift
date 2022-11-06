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
    let alertPresenter: AlertPresenter
    let view: IContactsView
    
    func onViewDidLoad() {
        let savedContacts = coreDataService.getContacts()
        print(savedContacts)
        if savedContacts.isEmpty {
            requestSender.send(requestConfig: RequestsFactory.contactsConfig()) { result in
                switch result {
                case Result.success(let contacts):
                    DispatchQueue.main.async {
                        view.contactsConfig(contacts: contacts)
                    }
                    saveContacts(contacts: contacts)
                case Result.failure(let error):
                    DispatchQueue.main.async {
                        switch error {
                        case NetworkError.badData, NetworkError.badURL:
                            Logger.shared.message(error.localizedDescription)
                        case NetworkError.noConnection:
                            alertPresenter.showAlert(message: "No Internet Connection")
                        }
                    }
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
