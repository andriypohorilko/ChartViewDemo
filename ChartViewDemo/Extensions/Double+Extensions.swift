//
//  Double+Extensions.swift
//  ChartViewDemo
//
//  Created by Andriy Pohorilko on 11/28/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
