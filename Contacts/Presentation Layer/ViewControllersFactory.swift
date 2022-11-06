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
        let coreDataStack = CoreDataStack()
        let coreDaraService = CoreDataService(coreDataStack: coreDataStack)
        let alertPresenter = AlertPresenter(viewController: view)
        let presenter = ContactsPresenter(requestSender: requestSender,
                                          coreDataService: coreDaraService,
                                          alertPresenter: alertPresenter,
                                          view: view)
        view.presenter = presenter
        return view
    }
}
