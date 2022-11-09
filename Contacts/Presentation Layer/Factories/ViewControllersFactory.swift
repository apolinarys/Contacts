//
//  ViewControllersFactory.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import UIKit

/// Фабрика контроллеров представления.
protocol IViewControllersFactory {
    
    // MARK: - Methods
    
    /// Возвращает экран контактов.
    func createContactsModule() -> UIViewController
}

struct ViewControllersFactory: IViewControllersFactory {
    
    // MARK: - Dependencies
    
    let requestSender = RequestSender()
    let requestsFactory = RequestsFactory()
    
    let alertPresenter = AlertPresenter()
    
    let coreDataStack = CoreDataStack()
    
    // MARK: - IViewControllersFactory
    
    func createContactsModule() -> UIViewController {
        let coreDataService = CoreDataService(coreDataStack: coreDataStack)
        
        let view = ContactsViewController()
        
        let router = ContactsRouter(
            transitionHandler: view,
            alertPresenter: alertPresenter
        )
        
        let presenter = ContactsPresenter(
            view: view,
            requestSender: requestSender,
            coreDataService: coreDataService,
            requestsFactory: requestsFactory,
            router: router
        )
        
        view.presenter = presenter
        
        return view
    }
}
