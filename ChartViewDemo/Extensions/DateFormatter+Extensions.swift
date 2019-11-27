//
//  DateFormatter+Extensions.swift
//  Wear2B_iOS
//
//  Created by Andriy Pohorilko on 5/14/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    func hourString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: date)
    }

    func weekDayString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
}
