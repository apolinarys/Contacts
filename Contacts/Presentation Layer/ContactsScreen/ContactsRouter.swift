//
//  ContactsRouter.swift
//  Contacts
//
//  Created by Macbook on 09.11.2022.
//

import UIKit

/// Роутер экрана контактов.
protocol IContactsRouter {
    
    // MARK: - Methods
    
    /// Отображает алерт ошибки.
    func presentErrorAllert(message: String)
}

struct ContactsRouter: IContactsRouter {
    
    // MARK: - Dependencies
    
    let transitionHandler: UIViewController
    
    let alertPresenter: IAlertPresenter
    
    // MARK: - IContactsRouter
    
    func presentErrorAllert(message: String) {
        DispatchQueue.main.async {
            alertPresenter.showErrorAlert(
                transitionHandler: transitionHandler,
                message: message
            )
        }
    }
}
