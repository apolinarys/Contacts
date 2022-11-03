//
//  ViewController.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import UIKit

final class ContactsViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupTableView()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactsTableViewCell.self))
        guard let cell = cell as? ContactsTableViewCell else { return UITableViewCell() }
        return cell
    }
}
