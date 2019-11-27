//
//  ButtonSelectable.swift
//  ChartViewDemo
//
//  Created by Andriy Pohorilko on 11/27/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import UIKit

protocol ButtonSelectable {
    var buttons: [UIButton] { get }
    func selectButton(_ sender: UIButton)
    func buttonPressed(_ sender: UIButton)
}

extension ButtonSelectable {
    func selectButton(_ sender: UIButton) {
        for button in buttons where button != sender {
            button.isSelected = false
        }
        guard !sender.isSelected else { return }
        sender.isSelected = true
    }
}
