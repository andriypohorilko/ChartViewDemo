//
//  DummyDataProvider.swift
//  ChartViewDemo
//
//  Created by Andriy Pohorilko on 11/27/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import Foundation

struct DummyDataProvider {
    static func createDatapoints(chartViewType: ChartViewType, glucoseUnits: GlucoseUnits) -> [Double] {
        var dataPoints: [Double] = []
        
        switch chartViewType {
        case .last8h:
            dataPoints = [220, 190, 180, 130, 200, 40, 175, 160, 165, 140, 190, 170, 155, 125, 135, 120,
                          250, 140, 150, 145, 178, 140, 145, 120, 135, 130, 140, 120, 125, 115]
        case .last24h:
            dataPoints = [220, 190, 180, 130, 200, 40, 175, 160, 165, 140, 190, 170, 155, 125, 135, 120,
                          250, 140, 150, 145, 178, 140, 145, 120, 135, 130, 140, 120, 125, 115, 220, 190,
                          180, 130, 200, 40, 175, 160, 165, 140, 190, 170, 155, 125, 135, 120, 250, 140,
                          150, 145, 178, 140, 145, 120, 135, 130, 140, 120, 125, 115]
        case .lastWeek:
            dataPoints = [220, 190, 180, 130, 200, 40, 175, 160, 165, 140, 190, 170, 155, 125,
                          135, 120, 250, 140, 150, 145, 178, 140, 145, 120, 135, 130, 140, 120,
                          125, 115, 220, 190, 180, 130, 200, 40, 175, 160, 165, 140, 190, 170,
                          155, 125, 135, 120, 250, 140, 150, 145, 178, 140, 145, 120, 135, 130,
                          140, 120, 125, 115, 220, 190, 180, 130, 200, 40, 175, 160, 165, 140,
                          190, 170, 155, 125, 135, 120, 250, 140, 150, 145, 178, 140, 145, 120,
                          135, 130, 140, 120, 125, 115]
        }
        
        dataPoints = dataPoints.map({ (value) -> Double in
            let glucose = GlucoseType(mgDl: value)
            return glucose.get(glucoseUnits)
        })
        return dataPoints
    }
}
