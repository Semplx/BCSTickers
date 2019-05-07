//
// Created by Олег Мельник on 2019-02-20.
// Copyright (c) 2019 Oleg Melnik. All rights reserved.
//

import Foundation

struct TickerDto: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case last
        case lowestAsk
        case highestBid
        case percentChange
        case baseVolume
        case quoteVolume
        case isFrozen
        case high24hr
        case low24hr
    }
    
    var id: Int
    var last: Double
    var lowestAsk: Double
    var highestBid: Double
    var percentChange: Double
    var baseVolume: Double
    var quoteVolume: Double
    var isFrozen: Bool
    var high24hr: Double
    var low24hr: Double
    
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        last = try values.decodeDouble(key: .last)
        lowestAsk = try values.decodeDouble(key: .lowestAsk)
        highestBid = try values.decodeDouble(key: .highestBid)
        percentChange = try values.decodeDouble(key: .percentChange)
        baseVolume = try values.decodeDouble(key: .baseVolume)
        quoteVolume = try values.decodeDouble(key: .quoteVolume)
        isFrozen = try values.decodeBool(key: .isFrozen)
        high24hr = try values.decodeDouble(key: .high24hr)
        low24hr = try values.decodeDouble(key: .low24hr)
    }
}
