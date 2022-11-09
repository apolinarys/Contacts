//
//  NetworkError.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import Foundation

/// Перечисление сетевых ошибок.
enum NetworkError: Error {
    
    case badURL
    
    case badData
    
    case noConnection
}
