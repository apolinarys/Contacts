//
//  ViewControllersFactory.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation
import UIKit

protocol IViewControllersFactory {
    func createContactsModule() -> UIViewController
}

struct ViewControllersFactory: IViewControllersFactory {
    
    func createContactsModule() -> UIViewController {
        let view = ContactsViewController()
        let requestSender = RequestSender()
        let presenter = ContactsPresenter(requestSender: requestSender, view: view)
        view.presenter = presenter
        return view
    }
}
