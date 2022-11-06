//
//  RequestsFactory.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation

struct RequestsFactory {
    static func contactsConfig() -> RequestConfig<Parser> {
        RequestConfig(request: Request(), parser: Parser())
    }
}
