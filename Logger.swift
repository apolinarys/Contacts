//
//  Logger.swift
//  Contacts
//
//  Created by Macbook on 03.11.2022.
//

import Foundation

struct Logger {
    static let shared = Logger()
    
    func message(_ message: String) {
        #if DEBUG
        print(message)
        #endif
    }
}

