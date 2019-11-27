//
//  GlucoseTrendViewController.swift
//  ChartViewDemo
//
//  Created by Andriy Pohorilko on 11/26/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import UIKit

protocol GlucoseTrendViewControllerDelegate: class {
    func setValues(_ values: [Double], start: Double, end: Double)
    func setMode(viewMode: GlucoseUnits, min: Double, max: Double)
}

final class GlucoseTrendViewController: UIViewController, ButtonSelectable {
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var periodStackView: UIStackView!
    @IBOutlet private weak var last8hButton: ChartTimeButton!
    @IBOutlet private weak var last24hButton: ChartTimeButton!
    @IBOutlet private weak var lastWeekButton: ChartTimeButton!
    @IBOutlet private weak var stackContanerView: UIView!
    @IBOutlet private weak var chartView: ChartView! {
        didSet {
            self.chartViewDelegate = chartView
        }
    }
    
    private var chartViewType: ChartViewType?
    private var glucoseUnits: GlucoseUnits {
        return .mg_dl
    }
    
    weak var chartViewDelegate: GlucoseTrendViewControllerDelegate?
    
    var buttons: [UIButton] {
        return [last8hButton, last24hButton, lastWeekButton]
    }
    
    var viewsToDecreaseAlphaAfterBlur: [UIView?] {
        return [titleLabel, chartView, periodStackView]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultChartViewType()
        
        stackContanerView.layer.cornerRadius = periodStackView.bounds.height
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        chartView.drawChart()
    }
    
    private func updateChart() {
        guard let chartViewType = chartViewType else {
            return
        }
        let data = DummyDataProvider.createDatapoints(chartViewType: chartViewType,
                                                      glucoseUnits: glucoseUnits)
        let start = 0.0
        var end = 0.0
        
        switch chartViewType {
        case .lastWeek:
            end = Constants.secondsInDay * 7
        case .last24h:
            end = Constants.secondsInDay
        case .last8h:
            end = Constants.secondsInHour * 8
        }
        chartViewDelegate?.setMode(viewMode: glucoseUnits,
                                   min: GlucoseType(mgDl: 40).get(glucoseUnits),
                                   max: GlucoseType(mgDl: 250).get(glucoseUnits))
        chartViewDelegate?.setValues(data, start: start, end: end)
    }
    
    @objc private func settingsChanged() {
        updateChart()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        selectButton(sender)
        selectChartViewType(sender)
    }
    
    private func selectChartViewType(_ sender: UIButton) {
        switch sender {
        case last8hButton:
            chartViewType = .last8h
        case last24hButton:
            chartViewType = .last24h
        case lastWeekButton:
            chartViewType = .lastWeek
        default:
            break
        }
        updateChart()
    }
    
    private func setDefaultChartViewType() {
        selectChartViewType(last8hButton)
    }
}
