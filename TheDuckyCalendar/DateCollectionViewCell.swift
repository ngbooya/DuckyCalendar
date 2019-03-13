//
//  DateCollectionViewCell.swift
//  TheDuckyCalendar
//
//  Created by Kevin Nguyen on 3/3/19.
//  Copyright © 2019 Kevin Nguyen. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var Circle: UIView!
    
    func DrawCircle(){
        let circleCenter = Circle.center
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: (Circle.bounds.width/2 - 5), startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        let CircleLayer = CAShapeLayer()
        CircleLayer.path = circlePath.cgPath
        CircleLayer.strokeColor = UIColor.red.cgColor
        CircleLayer.lineWidth = 2
        CircleLayer.strokeEnd = 0
        CircleLayer.fillColor = UIColor.clear.cgColor
        CircleLayer.lineCap = CAShapeLayerLineCap.round
        
        let Animation = CABasicAnimation(keyPath: "strokeEnd")
        Animation.duration = 1
        Animation.toValue = 1
        Animation.fillMode = CAMediaTimingFillMode.forwards
        Animation.isRemovedOnCompletion = false
        
        CircleLayer.add(Animation, forKey: nil)
        Circle.layer.addSublayer(CircleLayer)
        Circle.layer.backgroundColor = UIColor.clear.cgColor
    }
}
