//
//  RequestSender.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import Foundation

/// Обработчик запросов.
protocol IRequestSender {
    
    // MARK: - Methods
    
    func send<Parser>(requestConfig config: RequestConfig<Parser>,
                      completionHandler: @escaping (Result<Parser.Model, NetworkError>) -> Void)
}

struct RequestSender: IRequestSender {
    
    // MARK: - Private Properties
    
    private let session = URLSession.shared
    
    // MARK: - IRequestSender
    
    func send<Parser>(requestConfig config: RequestConfig<Parser>,
                      completionHandler: @escaping (Result<Parser.Model, NetworkError>) -> Void) where Parser: IParser {
        
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(Result.failure(NetworkError.badURL))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                return completionHandler(Result.failure(NetworkError.noConnection))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completionHandler(Result.failure(NetworkError.badData))
            }
            
            if response.statusCode == -1009 {
                return completionHandler(Result.failure(NetworkError.noConnection))
            }
            
            if response.statusCode == -1001 {
                return completionHandler(Result.failure(NetworkError.timeOut))
            }
            
            guard let data = data, let parsedModel: Parser.Model = config.parser.parse(data: data) else {
                completionHandler(Result.failure(NetworkError.badData))
                return
            }
            
            completionHandler(Result.success(parsedModel))
        }
        
        task.resume()
    }
}
