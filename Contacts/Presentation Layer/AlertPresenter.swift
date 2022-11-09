//
//  AlertPresenter.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import UIKit

protocol IAlertPresenter {
    
    // MARK: - Methods
    
    func showErrorAlert(transitionHandler: UIViewController, message: String, actions: [UIAlertAction]?)
}

struct AlertPresenter: IAlertPresenter {
    
    // MARK: - IAlertPresenter
    
    func showErrorAlert(transitionHandler: UIViewController, message: String, actions: [UIAlertAction]?) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let action = UIAlertAction(
            title: "Ok",
            style: UIAlertAction.Style.cancel
        )
        
        alert.addAction(action)
        
        if let actions = actions {
            actions.forEach {
                alert.addAction($0)
            }
        }
        
        transitionHandler.present(alert, animated: true)
    }
}
