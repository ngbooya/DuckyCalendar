//
//  Animations.swift
//  TheDuckyCalendar
//
//  Created by Kevin Nguyen on 3/13/19.
//  Copyright © 2019 Kevin Nguyen. All rights reserved.
//

import UIKit

func MoveAnimationNext(Label: UILabel, Cal: UICollectionView){
    
    let positionAnimation = CABasicAnimation(keyPath: "position")
    positionAnimation.fromValue = NSValue(cgPoint: CGPoint(x: Label.center.x + 70,y:Label.center.y))
    positionAnimation.toValue = NSValue(cgPoint: CGPoint(x: Label.center.x,y:Label.center.y))
    positionAnimation.duration = 0.3
//    positionAnimation.fromValue = NSValue(cgPoint: CGPoint(x: Cal.center.x + 70,y:Cal.center.y))
//    positionAnimation.toValue = NSValue(cgPoint: CGPoint(x: Cal.center.x,y:Cal.center.y))
//    positionAnimation.duration = 0.3
    
    let fadeAnimation = CABasicAnimation(keyPath: "opacity")
    fadeAnimation.fromValue = 0
    fadeAnimation.toValue = 1
    fadeAnimation.duration = 0.3
    
    //Add animation to gesture
    Label.layer.add(positionAnimation, forKey: nil)
    Label.layer.add(fadeAnimation, forKey: nil)
//    Cal.layer.add(positionAnimation, forKey: nil)
//    Cal.layer.add(fadeAnimation, forKey: nil)
    
    
}

func MoveAnimationBack(Label: UILabel, Cal: UICollectionView){
    let positionAnimation = CABasicAnimation(keyPath: "position")
    positionAnimation.fromValue = NSValue(cgPoint: CGPoint(x: Label.center.x - 70,y:Label.center.y))
    positionAnimation.toValue = NSValue(cgPoint: CGPoint(x: Label.center.x,y:Label.center.y))
    positionAnimation.duration = 0.3
//    positionAnimation.fromValue = NSValue(cgPoint: CGPoint(x: Cal.center.x - 70,y:Cal.center.y))
//    positionAnimation.toValue = NSValue(cgPoint: CGPoint(x: Cal.center.x,y:Cal.center.y))
//    positionAnimation.duration = 0.3
    
    let fadeAnimation = CABasicAnimation(keyPath: "opacity")
    fadeAnimation.fromValue = 0
    fadeAnimation.toValue = 1
    fadeAnimation.duration = 0.3
    
    Label.layer.add(positionAnimation, forKey: nil)
    Label.layer.add(fadeAnimation, forKey: nil)
//    Cal.layer.add(positionAnimation, forKey: nil)
//    Cal.layer.add(fadeAnimation, forKey: nil)
}
