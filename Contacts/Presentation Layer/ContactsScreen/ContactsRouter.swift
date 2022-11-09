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
    func presentErrorAlert(message: String, actions: [UIAlertAction]?)
}

struct ContactsRouter: IContactsRouter {
    
    // MARK: - Dependencies
    
    let transitionHandler: UIViewController
    
    let alertPresenter: IAlertPresenter
    
    // MARK: - IContactsRouter
    
    func presentErrorAlert(message: String, actions: [UIAlertAction]?) {
        DispatchQueue.main.async {
            alertPresenter.showErrorAlert(
                transitionHandler: transitionHandler,
                message: message,
                actions: actions
            )
        }
    }
}
