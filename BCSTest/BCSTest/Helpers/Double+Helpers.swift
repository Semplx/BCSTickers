//
//  Double+Helpers.swift
//  BCSTest
//
//  Created by Олег Мельник on 05/05/2019.
//  Copyright © 2019 Oleg Melnik. All rights reserved.
//

import Foundation

extension Double {
    func stringWithDecimals(_ number: Int) -> String {
        return String(format: "%.\(number)f", self)
    }
}
