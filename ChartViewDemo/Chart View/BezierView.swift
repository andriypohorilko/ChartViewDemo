//
//  BezierView.swift
//  Wear2B_iOS
//
//  Created by Andriy Pohorilko on 7/31/19.
//  Copyright © 2019 Andriy Pohorilko. All rights reserved.
//

import UIKit

final class BezierView: UIView {
    private var path: UIBezierPath!
    private var yMaximum: CGFloat = 1.0
    private var xMaximum: CGFloat = 1.0
    
    var data: [CGPoint] = [] {
        didSet {
            xMaximum = data.reduce(-CGFloat.greatestFiniteMagnitude, { max($0, $1.x) })
            yMaximum = data.reduce(-CGFloat.greatestFiniteMagnitude, { max($0, $1.y) })
            setNeedsDisplay()
        }
    }
    
    private func scale(point: CGPoint) -> CGPoint {
        return  CGPoint(x: bounds.width * point.x / xMaximum,
                        y: (bounds.height - bounds.height * point.y / yMaximum))
    }
    
    override func draw(_ rect: CGRect) {
        if data.count <= 1 {
            return
        }
        path = drawCubicCurvedPath(color: .red, radius: 3);
        let mask = CAShapeLayer()
        mask.fillColor = nil
        mask.strokeColor = UIColor.black.cgColor
        mask.lineWidth = 2
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    private func drawCubicCurvedPath(color: UIColor, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        guard !data.isEmpty else {
            return path
        }
        
        var point1 = scale(point: data[0])
        path.move(to: point1)
        var oldControlP = point1
        
        for i in 0..<data.count {
            let point2 = scale(point: data[i])
            var point3: CGPoint?
            if i < data.count - 1 {
                point3 = scale(point: data [i+1])
            }
            
            let newControlP = controlPointForPoints(point1: point1, point2: point2, point3: point3)
            
            path.addCurve(to: point2, controlPoint1: oldControlP, controlPoint2: newControlP ?? point2)
            oldControlP = calculateMirrorFor(point1: newControlP, center: point2) ?? point1
            if let point3 = point3 {
                if oldControlP.x > point3.x { oldControlP.x = point3.x }
            }
            point1 = point2
        }
        return path
    }
    
    private func calculateMirrorFor(point1: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let point1 = point1, let center = center else {
            return nil
        }
        let newX = center.x + center.x - point1.x
        let newY = center.y + center.y - point1.y
        
        return CGPoint(x: newX, y: newY)
    }
    
    private func controlPointForPoints(point1: CGPoint, point2: CGPoint, point3: CGPoint?) -> CGPoint? {
        guard let point3 = point3 else { return nil }
        
        let leftMidPoint  = midPointForPoints(point1: point1, point2: point2)
        let rightMidPoint = midPointForPoints(point1: point2, point2: point3)
        let imaginPoint = calculateMirrorFor(point1: rightMidPoint, center: point2)
        
        var controlPoint = midPointForPoints(point1: leftMidPoint, point2: imaginPoint!)
        
        controlPoint.y = clamp(num: controlPoint.y, bounds1: point1.y, bounds2: point2.y)
        
        let flippedP3 = point2.y + (point2.y-point3.y)
        
        controlPoint.y = clamp(num: controlPoint.y, bounds1: point2.y, bounds2: flippedP3)
        controlPoint.x = clamp(num: controlPoint.x, bounds1: point1.x, bounds2: point2.x)
        return controlPoint
    }
    
    private func midPointForPoints(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
    }
    
    private func clamp(num: CGFloat, bounds1: CGFloat, bounds2: CGFloat) -> CGFloat {
        if bounds1 < bounds2 {
            return min(max(bounds1, num), bounds2)
        } else {
            return min(max(bounds2, num), bounds1)
        }
    }
}
