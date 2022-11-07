//
//  RequestSender.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import Foundation

protocol IRequestSender {
    func send<Parser>(requestConfig config: RequestConfig<Parser>,
                      completionHandler: @escaping (Result<Parser.Model, NetworkError>) -> Void)
}

struct RequestSender: IRequestSender {
    
    let session = URLSession.shared
    
    func send<Parser>(requestConfig config: RequestConfig<Parser>, completionHandler: @escaping (Result<Parser.Model, NetworkError>) -> Void) where Parser: IParser {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(Result.failure(NetworkError.badURL))
            return
        }
        let task = session.dataTask(with: urlRequest) { data, status, error in
            if error != nil {
                completionHandler(Result.failure(NetworkError.noConnection))
                return
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
