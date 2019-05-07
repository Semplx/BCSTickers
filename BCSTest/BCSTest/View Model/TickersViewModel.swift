//
//  TickerItemViewModel.swift
//  BCSTest
//
//  Created by Олег Мельник on 07/05/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import UIKit
import RxSwift

protocol UpdatableViewModel: class {
    var needsUpdate: Bool { get set }
    var isUpdating: Bool { get }
    func startUpdating()
    func stopUpdating()
}

final class TickersViewModel: UpdatableViewModel {
    
    var needsUpdate: Bool = false {
        didSet {
            if needsUpdate {
                startUpdating()
            } else {
                stopUpdating()
            }
        }
    }
    var isUpdating: Bool {
        return updateDisposable != nil
    }
    
    let dataSource = PublishSubject<[TickerItemViewModel]>()
    let networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    private let retryTime: RxTimeInterval = 5.0
    private var updateDisposable: Disposable?
    
    func startUpdating() {
        updateDisposable = Observable<Int>.interval(5.0, scheduler: MainScheduler.instance)
            .startWith(0)
            .flatMap { _ in
                self.networkManager.tickers()
            }
            .map {
                let arr = $0.map { TickerItemViewModel(name: $0.key, dto: $0.value) }
                let sortArr = arr.sorted { $0.id < $1.id }
                return sortArr
            }
            .debug()
            .bind(to: dataSource)
    }
    
    func stopUpdating() {
        updateDisposable?.dispose()
        updateDisposable = nil
    }
}
