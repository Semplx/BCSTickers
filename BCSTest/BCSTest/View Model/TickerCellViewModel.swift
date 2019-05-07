//
//  TickerCellViewModel.swift
//  BCSTest
//
//  Created by Олег Мельник on 02/05/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import UIKit
import RxSwift

final class TickerCellViewModel {
    let tickerName = PublishSubject<String>()
    let last = PublishSubject<Double>()
    let highestBid = PublishSubject<Double>()
    let percentChange = PublishSubject<Double>()
}
