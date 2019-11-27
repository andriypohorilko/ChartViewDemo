//
//  Glucose.swift
//  Wear2B_iOS
//
//  Created by Andriy Pohorilko on 9/17/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import UIKit

struct GlucoseType {
	var value: Int
	
	init(mgDl: Double) {
		value = Int(mgDl * 1000)
	}
	
	init(mmolL: Double) {
		value = Int(mmolL * 18000)
	}
	
    init(_ value: Double, units: GlucoseUnits) {
		switch units {
		case .mg_dl:
			self.init(mgDl: value)
		default:
			self.init(mmolL: value)
		}
	}

	func get(_ unit: GlucoseUnits) -> Double {
		switch unit {
		case .mg_dl:
			return Double(value) / 1000.0
		default:
			return Double(value) / 18000.0
		}
	}
}
