//
//  Request.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import Foundation

struct ContactsRequest: IRequest {
    
    // MARK: - IRequest
    
    var urlRequest: URLRequest? {
        guard let components = createURLComponents(),
              let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        
        request.timeoutInterval = 30
        
        return request
    }
    
    // MARK: - Private Methods
    
    private func createURLComponents() -> URLComponents? {
        var components = URLComponents()

        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        
        return components
    }
}
