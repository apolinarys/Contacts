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
    let alertPresenter: ErrorAlertPresenter
    let requestsFactory: IRequestFactory
    let view: IContactsView
    
    func onViewDidLoad() {
        setDate()
        manageContacts()
    }
    
    private func manageContacts() {
        let savedContacts = coreDataService.getContacts()
        if doNeedUpdateData() {
            coreDataService.deleteContacts()
            requestSender.send(requestConfig: requestsFactory.contactsConfig()) { result in
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
    
    private func setDate() {
        UserDefaults.standard.set(Date(timeIntervalSinceNow: 60 * 60), forKey: UserDefaultsKeys.DateKey)
    }
    
    private func doNeedUpdateData() -> Bool {
        if let date = UserDefaults.standard.object(forKey: UserDefaultsKeys.DateKey) as? Date, Date() < date {
            return false
        }
        return true
    }
    
    private func saveContacts(contacts: [Contact]) {
        coreDataService.saveContacts(contacts: contacts)
    }
}
