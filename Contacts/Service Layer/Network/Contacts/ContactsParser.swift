//
//  Parser.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import Foundation

/// Парсер контактов.
struct ContactsParser: IParser {
    
    // MARK: - IParser
    
    typealias Model = [Contact]
    
    func parse(data: Data) -> Model? {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
        
        do {
            let decodedData = try decoder.decode(ContactResponseModel.self, from: data)
            
            var contacts = decodedData.company.employees.compactMap {
                Contact(
                    name: $0.name,
                    phoneNumber: $0.phoneNumber,
                    skills: $0.skills
                )
            }
            
            contacts = contacts.sorted { $0.name < $1.name }
            
            return contacts
        } catch {
            return nil
        }
    }
}
