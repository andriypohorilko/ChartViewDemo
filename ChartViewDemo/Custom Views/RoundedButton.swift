//
//  RoundedButton.swift
//  ChartViewDemo
//
//  Created by Andriy Pohorilko on 11/27/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius()
    }
    
    private func setCornerRadius() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}
