//
//  Router.swift
//  Contacts
//
//  Created by Macbook on 05.11.2022.
//

import Foundation
import UIKit

protocol IRouter {
    
}

struct Router: IRouter {
    
    let navigationController: UINavigationController
    let viewControllersFactory: IViewControllersFactory
    
    func initialViewController() {
        let contactsViewController = viewControllersFactory.createContactsModule()
        navigationController.viewControllers = [contactsViewController]
    }
}
