//
//  ColoredButton.swift
//  Wear2B_iOS
//
//  Created by Andriy Pohorilko on 4/18/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import UIKit

class ColoredButton: RoundedButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override var isEnabled: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    var titleColorForNormalState: UIColor {
        return .white
    }
    
    var titleColorForDisabledState: UIColor {
        return .grayButtonText
    }
    
    func setupView() {
        setTitleColor(UIColor.gray, for: .highlighted)
        setTitleColor(titleColorForNormalState, for: .normal)
        setTitleColor(titleColorForDisabledState, for: .disabled)
        updateBackgroundColor()
    }
    
    func updateBackgroundColor() {
        backgroundColor = isEnabled ? .mainGreen : .grayBackground
    }
}
