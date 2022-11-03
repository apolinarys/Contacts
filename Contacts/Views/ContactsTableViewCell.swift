//
//  ContactsTableViewCell.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}
