//
//  NetworkManager.swift
//  BCSTest
//
//  Created by Олег Мельник on 30/04/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire

let endpoint = "https://poloniex.com/public?command=returnTicker"

protocol NetworkManageable: class {
    func tickers() -> Observable<[String: TickerDto]>
}

class NetworkManager: NetworkManageable {
    
    func tickers() -> Observable<[String: TickerDto]> {
        return RxAlamofire.data(.get, endpoint)
            .map{ (responseData) -> [String: TickerDto] in
                do {
                    let decodedJson = try JSONDecoder().decode([String: TickerDto].self, from: responseData)
                    return decodedJson
                } catch {
                    return [:]
                }
        }
    }
}
