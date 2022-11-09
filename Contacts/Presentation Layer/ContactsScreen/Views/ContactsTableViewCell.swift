//
//  ContactsTableViewCell.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import UIKit

final class ContactsTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    /// Лейбл имени.
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        return label
    }()
    
    /// Лейбл номера.
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Лейбл талантов.
    private lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewCell
    
    override func prepareForReuse() {
        nameLabel.text = nil
        phoneLabel.text = nil
        skillsLabel.text = nil
    }
    
    // MARK: - Configuration
    
    /// Конфигурирует ячейку.
    /// - Parameters:
    ///  - contact: Модель контакта.
    func configure(contact: Contact) {
        nameLabel.text = contact.name
        phoneLabel.text = contact.phoneNumber
        skillsLabel.text = contact.skills.joined(separator: " * ")
    }
    
    // MARK: - Private Methods
    
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
