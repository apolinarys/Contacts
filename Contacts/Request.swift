//
//  Request.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import Foundation

protocol IRequest {
    var urlRequest: URLRequest? {get}
}

struct Request: IRequest {
    
    var urlRequest: URLRequest? {
        guard let components = createURLComponents(), let url = components.url else { return nil }
        return URLRequest(url: url)
    }
    
    private func createURLComponents() -> URLComponents? {
        
        var components = URLComponents()

        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        
        return components
    }
}
