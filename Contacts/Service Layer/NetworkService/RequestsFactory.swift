//
//  RequestsFactory.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation

protocol IRequestFactory {
    func contactsConfig() -> RequestConfig<ContactsParser>
}

struct RequestsFactory: IRequestFactory {
    func contactsConfig() -> RequestConfig<ContactsParser> {
        RequestConfig(request: ContactsRequest(), parser: ContactsParser())
    }
}
