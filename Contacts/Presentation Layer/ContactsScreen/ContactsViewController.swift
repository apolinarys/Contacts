//
//  ViewController.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import UIKit

/// Представление экрана контактов.
protocol IContactsView {
    
    // MARK: - Methods
    
    func contactsConfig(contacts: [Contact])
}

final class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IContactsView {
    
    // MARK: - Properties
    
    var presenter: IContactsPresenter?
    
    // MARK: - Private Properties
    
    private var contacts: [Contact] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        
        tableView.register(
            ContactsTableViewCell.self,
            forCellReuseIdentifier: String(describing: ContactsTableViewCell.self)
        )
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupNavigationBar()
        
        presenter?.onViewDidLoad()
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactsTableViewCell.self))
        
        guard let cell = cell as? ContactsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(contact: contacts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - IContactsView
    
    func contactsConfig(contacts: [Contact]) {
        self.contacts = contacts
        
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Contacts"
    }
}
