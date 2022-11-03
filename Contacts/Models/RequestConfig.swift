//
//  RequestConfig.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import Foundation

struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}
