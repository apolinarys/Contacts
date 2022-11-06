//
//  ContactsPresenter.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation

protocol IContactsPresenter {
    func onViewDidLoad()
}

struct ContactsPresenter: IContactsPresenter {
    
    let requestSender: IRequestSender
    let view: IContactsView
    
    func onViewDidLoad() {
        requestSender.send(requestConfig: RequestsFactory.contactsConfig()) { result in
            switch result {
            case .success(let contacts):
                DispatchQueue.main.async {
                    view.contactsConfig(contacts: contacts)
                }
            case .failure(let error):
                Logger.shared.message(error.localizedDescription)
            }
        }
    }
}
