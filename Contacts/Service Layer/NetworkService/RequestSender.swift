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
        let cache = URLCache.shared
        let task = session.downloadTask(with: urlRequest) { url, response, error in
            if error != nil {
                completionHandler(Result.failure(NetworkError.noConnection))
                return
            }
            guard let response = response, let url = url,
                  cache.cachedResponse(for: urlRequest) == nil,
                  let data = try? Data(contentsOf: url),
                  let parsedModel: Parser.Model = config.parser.parse(data: data) else {
                completionHandler(Result.failure(NetworkError.badData))
                return
            }
            completionHandler(Result.success(parsedModel))
            cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: urlRequest)
        }
        task.resume()
//        let task = session.dataTask(with: urlRequest) { data, _, error in
//            if error != nil {
//                completionHandler(Result.failure(NetworkError.noConnection))
//                return
//            }
//            guard let data = data, let parsedModel: Parser.Model = config.parser.parse(data: data) else {
//                completionHandler(Result.failure(NetworkError.badData))
//                return
//            }
//            completionHandler(Result.success(parsedModel))
//        }
//        task.resume()
    }
}
