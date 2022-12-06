//
//  APIConstants.swift
//  Payback
//
//  Created by Emre Boyaci on 5.12.2022.
//

import Foundation

final class APIConstants {
    #if TEST
        static let apiURL = "https://api-test.payback.com/transactions"
    #elseif PROD
        static let apiURL = "https://api.payback.com/transactions"
    #endif
}
