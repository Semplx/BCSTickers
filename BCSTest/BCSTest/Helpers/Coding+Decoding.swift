//
//  Coding+Decoding.swift
//  BCSTest
//
//  Created by Олег Мельник on 30/04/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeDouble(key: K) throws -> Double {
        return Double(try self.decode(String.self, forKey: key)) ?? 0
    }
    
    func decodeBool(key: K) throws -> Bool {
        return Bool(try self.decode(String.self, forKey: key)) ?? false
    }
}
