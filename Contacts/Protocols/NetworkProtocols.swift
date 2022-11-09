//
//  Protocols.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation

/// Парсер ответа на запрос.
protocol IParser {
    
    // MARK: - Associated Type
    
    associatedtype Model
    
    // MARK: - Methods
    
    /// Возвращает модель.
    /// - Parameters:
    ///  - data: Дата ответа на запрос.
    func parse(data: Data) -> Model?
}

/// Запрос.
protocol IRequest {
    
    // MARK: - Properties
    
    var urlRequest: URLRequest? {get}
}
