//
//  ViewController.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import UIKit

protocol IContactsView {
    func contactsConfig(contacts: [Contact])
}

final class ContactsViewController: UIViewController, IContactsView {
    
    private lazy var tableView = UITableView(frame: view.frame)
    private var contacts: [Contact] = []
    var presenter: IContactsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupTableView()
        presenter?.onViewDidLoad()
        setupNavigationBar()
    }
    
    func contactsConfig(contacts: [Contact]) {
        self.contacts = contacts
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Contacts"
    }
    
    private func setupTableView() {
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: String(describing: ContactsTableViewCell.self))
        tableView.dataSource = self
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactsTableViewCell.self))
        guard let cell = cell as? ContactsTableViewCell else { return UITableViewCell() }
        cell.configure(contact: contacts[indexPath.row])
        return cell
    }
}
