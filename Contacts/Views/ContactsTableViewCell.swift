//
//  ContactsTableViewCell.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import UIKit

final class ContactsTableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        label.text = "Name"
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone"
        return label
    }()
    
    private lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Skills"
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        phoneLabel.text = ""
        skillsLabel.text = ""
    }
    
    func configure(contact: Contact) {
        nameLabel.text = contact.name
        phoneLabel.text = contact.phoneNumber
        var skills = ""
        for skill in contact.skills {
            if skill == contact.skills.last {
                skills += skill
            } else {
                skills += skill + " * "
            }
        }
        skillsLabel.text = skills
    }
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(skillsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            phoneLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            skillsLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            skillsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            skillsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
