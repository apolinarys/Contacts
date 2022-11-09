//
//  ContactsPresenter.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation
import UserNotifications

/// Презентер экрана контактов.
protocol IContactsPresenter {
    
    // MARK: - Methods
    
    func onViewDidLoad()
}

struct ContactsPresenter: IContactsPresenter {
    
    // MARK: - Dependencies
    
    let view: IContactsView
    
    let requestSender: IRequestSender
    let coreDataService: ICoreDataService
    let requestsFactory: IRequestFactory
    
    let router: IContactsRouter
    
    // MARK: - IContactsPresenter
    
    func onViewDidLoad() {
        setDate()
        manageContacts()
    }
    
    // MARK: - Private Methods
    
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
                        switch error {
                        case NetworkError.badData, NetworkError.badURL:
                            Logger.shared.message(error.localizedDescription)
                        case NetworkError.noConnection:
                            router.presentErrorAllert(message: "No Internet Connection")
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
