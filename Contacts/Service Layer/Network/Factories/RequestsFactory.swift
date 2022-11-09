//
//  RequestsFactory.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation

/// Фабрика запросов.
protocol IRequestFactory {
    
    // MARK: - Private Methods
    
    /// Возвращает запрос контаков.
    func contactsConfig() -> RequestConfig<ContactsParser>
}

struct RequestsFactory: IRequestFactory {
    
    // MARK: - IRequestFactory
    
    func contactsConfig() -> RequestConfig<ContactsParser> {
        RequestConfig(
            request: ContactsRequest(),
            parser: ContactsParser()
        )
    }
}
