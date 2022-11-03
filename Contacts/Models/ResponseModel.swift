//
//  ResponseModel.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import Foundation

struct ResponseModel: Decodable {
    let company: Company
}

extension ResponseModel {
    struct Company: Decodable {
        let name: String
        let employees: [Employee]
    }
    
    struct Employee: Decodable {
        let name: String
        let phoneNumber: String
        let skills: [String]
    }
}
