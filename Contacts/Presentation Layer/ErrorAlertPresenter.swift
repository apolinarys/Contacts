//
//  AlertPresenter.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import UIKit

struct ErrorAlertPresenter {
    
    let viewController: UIViewController
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
}
