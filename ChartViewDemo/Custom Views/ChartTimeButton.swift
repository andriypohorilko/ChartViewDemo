//
//  ChartTimeButton.swift
//  ChartViewDemo
//
//  Created by Andriy Pohorilko on 11/27/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import UIKit

final class ChartTimeButton: ColoredButton {
    override var isSelected: Bool {
        didSet {
            updateButtonTitle()
            updateBackgroundColor()
        }
    }
    
    override var titleColorForNormalState: UIColor {
        return #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
    }
    
    var titleColorForSelectedState: UIColor? {
        return .white
    }
    
    override func setupView() {
        super.setupView()
        updateButtonTitle()
        setTitleColor(titleColorForSelectedState, for: .selected)
    }
    
    override func updateBackgroundColor() {
        backgroundColor = isSelected ? .mainGreen : .grayBackground
    }
    
    private func updateButtonTitle() {
        titleLabel?.font = isSelected ? .robotoBold(size: 16) : .robotoRegular(size: 16)
    }
}
