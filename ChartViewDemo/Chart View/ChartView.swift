//
//  ChartView.swift
//  Wear2B_iOS
//
//  Created by Andriy Pohorilko on 4/27/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import UIKit

final class ChartView: NibView {
    @IBOutlet private weak var bezierView: BezierView!
    @IBOutlet private weak var verticalLinesStackView: UIStackView!
    @IBOutlet private weak var bottomStackView: UIStackView!
	@IBOutlet private weak var leftStackView: UIStackView!
	@IBOutlet private weak var maxLabel: UILabel!
	@IBOutlet private weak var minLabel: UILabel!
	
	private var mode: GlucoseUnits = .mg_dl
	private var valueFormat: String {
		return "%2.0f"
	}
	
    private var lowestChartValue = 40.0
	private var startValue = 0.0
	private var endValue = 0.0
	
	private var minValue = 40.0
	private var maxValue = 250.0
    
    private var bezierViewSize: CGSize {
        return bezierView.frame.size
    }
	
    private var bottomLabelsData = [String]()
    private var dataPoints = [Double]() {
        didSet {
			fillBottomLabelsData()
            drawChart()
        }
    }
    
    private var xAxisPoints: [Double] {
        var points = [Double]()
        for i in 0..<dataPoints.count {
            let val = ((Double(i)) * Double(bezierViewSize.width) / Double(dataPoints.count))
            points.append(val)
        }
        return points
    }
    
    private var yAxisPoints: [Double] {
        var points = [Double]()
        for i in dataPoints {
            let val = ((Double(i) - lowestChartValue)) * Double(bezierViewSize.height)
            points.append(val)
        }
        return points
    }
    
    private var graphPoints: [CGPoint] {
        var points = [CGPoint]()
        for i in 0..<dataPoints.count {
            let val = CGPoint(x: self.xAxisPoints[i], y: self.yAxisPoints[i])
            points.append(val)
        }
        return points
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func drawChart() {
        bezierView.data = graphPoints
        addTimeLabels()
		initVerticalAxe()
	}

	private func fillBottomLabelsData() {
		var data: [String] = []
		var date = Date().addingTimeInterval(startValue)
		let step: Double = (endValue - startValue) / 6.0
		
		for _ in 0...6 {
			let text = step >= Constants.secondsInDay ? DateFormatter().weekDayString(date) : DateFormatter().hourString(date)
			data.insert(text, at: 0)
			date = date.addingTimeInterval(step)
		}
		self.bottomLabelsData = data
	}
	
	private static func addLableToStack(_ stackView: UIStackView, text: String) {
		let label = UILabel()
		label.text = text
		label.textAlignment = .center
		label.textColor = #colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
		label.font = .robotoRegular(size: 12)
		stackView.addArrangedSubview(label)
	}
    
    private func addTimeLabels() {
        clearTimeLabelsAndLines()
        for i in 0..<bottomLabelsData.count {
			ChartView.addLableToStack(bottomStackView, text: bottomLabelsData[i])
            
            let verticalLine = UIView(frame: .zero)
            verticalLine.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
            
            verticalLinesStackView.addArrangedSubview(verticalLine)
            verticalLine.addConstraints([
                verticalLine.widthAnchor.constraint(equalToConstant: 1),
                verticalLine.heightAnchor.constraint(equalToConstant: bezierViewSize.height)
                ])
        }
    }
	
	private func initVerticalAxe() {
		leftStackView.removeAllArrangedSubviews()
		let pointCount = 8
		let step = (minValue - maxValue) / Double(pointCount - 1)
		let format = self.valueFormat
		
		for val in stride(from: maxValue, through: minValue, by: step) {
			let text = String(format: format, val)
			ChartView.addLableToStack(leftStackView, text: text )
		}
	}
    
    private func clearTimeLabelsAndLines() {
        bottomStackView.removeAllArrangedSubviews()
        verticalLinesStackView.removeAllArrangedSubviews()
    }
}

extension ChartView: GlucoseTrendViewControllerDelegate {
	func setValues(_ values: [Double], start: Double, end: Double) {
		self.startValue = start
		self.endValue = end
		
		if self.mode != .mg_dl {
			let units = self.mode
			dataPoints = values.map({ (value) -> Double in
				let glucose = GlucoseType(value, units: units)
				return glucose.get(.mg_dl)
			})
		} else {
			dataPoints = values
		}
	}
	
	func setMode(viewMode: GlucoseUnits, min: Double, max: Double) {
		self.mode = viewMode
		self.minValue = min
		self.maxValue = max
	}
}
