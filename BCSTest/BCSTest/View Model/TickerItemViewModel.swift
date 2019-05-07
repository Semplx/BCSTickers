//
//  TickersViewModel.swift
//  BCSTest
//
//  Created by Олег Мельник on 06/05/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import UIKit

final class TickerItemViewModel {
    let name: String
    private let dto: TickerDto
    
    var id: Int {
        return dto.id
    }
    
    var last: Double {
        return dto.last
    }
    
    var highestBid: Double {
        return dto.highestBid
    }
    
    var percentChange: Double {
        return dto.percentChange
    }
    
    init(name: String, dto: TickerDto) {
        self.name = name
        self.dto = dto
    }
}
