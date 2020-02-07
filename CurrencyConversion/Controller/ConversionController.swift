//
//  ConversionController.swift
//  CurrencyConversion
//
//  Created by Pedro Nascimento on 05/02/20.
//  Copyright © 2020 PedroNascimento. All rights reserved.
//

import UIKit
import Alamofire

class ConversionController {
    
    static var rates: [String]?
    
    static func getCurrencys(currency: String, completion: @escaping (_ currency: Currency?) -> Void) {
        
        
        AF.request("https://api.exchangeratesapi.io/latest?base=\(currency)").response { response in
            
            switch response.result {
            case .success(let value):
                if let data = value {
                    let currency = try? JSONDecoder().decode(Currency.self, from: data)
                    
                    if let rates = currency?.rates {
                        ConversionController.rates = Array(rates.keys)
                    }
                    
                    completion(currency)
                } else {
                    handleError()
                }
                
            case .failure( _ ):
                handleError()
            }
        }
    }
    
    static func handleError() {
        
    }
}
