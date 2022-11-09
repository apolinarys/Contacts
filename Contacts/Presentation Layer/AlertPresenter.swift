//
//  AlertPresenter.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import UIKit

protocol IAlertPresenter {
    
    // MARK: - Methods
    
    func showErrorAlert(transitionHandler: UIViewController, message: String)
}

struct AlertPresenter: IAlertPresenter {
    
    // MARK: - IAlertPresenter
    
    func showErrorAlert(transitionHandler: UIViewController, message: String) {
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
        
        transitionHandler.present(alert, animated: true)
    }
}
