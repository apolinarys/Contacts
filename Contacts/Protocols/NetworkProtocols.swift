//
//  Protocols.swift
//  Contacts
//
//  Created by Macbook on 06.11.2022.
//

import Foundation

protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}

protocol IRequest {
    var urlRequest: URLRequest? {get}
}
