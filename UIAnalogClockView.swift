//
//  AnalogClockView.swift
//  AnalogClock
//
//  Created by Fady Yecob on 21.02.18.
//  Copyright © 2018 Fady Yecob. All rights reserved.
//

import UIKit

public class UIAnalogClockView: UIView {
    var circleLayer: CALayer!
    var hourHandLayer: CALayer!
    var minuteHandLayer: CALayer!
    var secondHandLayer: CALayer!
    
    open var textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    open var customTime: Date?
    
    open var handColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    open var secondsHandColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0, alpha: 1)
    
    override public func draw(_ rect: CGRect) {
        
        layer.masksToBounds = true
        layer.cornerRadius = rect.width / 2
        
        // Instantiate circleLayer and put it into the main rect
        circleLayer = CALayer()
        circleLayer.frame = rect
        self.layer.addSublayer(circleLayer)
        
        let radius = frame.width/2
        for position in 0..<12 {
            let label = CATextLayer()
            label.fontSize = rect.width/11
            label.font = UIFont.boldSystemFont(ofSize: rect.width/11)
            label.foregroundColor = textColor.cgColor
            label.contentsScale = UIScreen.main.scale
            label.alignmentMode = .center

            let hours = (position+3) % 12
            let theta = Double(position) / 6.0 * Double.pi
            
            let x = CGFloat(cos(theta)) * 0.85 * radius + radius
            let y = CGFloat(sin(theta)) * 0.85 * radius + radius


            let frame = CGRect(x: x, y: y, width: rect.width/10, height: rect.height/10)
            label.frame = frame
            
            label.position = .init(x: x, y: y)

            if hours == 0 {
                label.string = "12"
            } else {
                label.string = "\(hours)"
            }
            circleLayer.addSublayer(label)

        }
        
        // Create and draw second hand layer
        secondHandLayer = CALayer()
        secondHandLayer.backgroundColor = secondsHandColor.cgColor
        // Puts the center of the rectangle in the center of the clock
        secondHandLayer.anchorPoint = CGPoint(x: 0.5, y: 0.2)
        // Positions the hand in the middle of the clock
        secondHandLayer.position = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        
        // Create and draw hour hand layer
        hourHandLayer = CALayer()
        hourHandLayer.backgroundColor = handColor.cgColor
        // Puts the center of the rectangle in the center of the clock
        hourHandLayer.anchorPoint = CGPoint(x: 0.5, y: 0.039)
        // Positions the hand in the middle of the clock
        hourHandLayer.position = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        
        // Create and draw minute hand layer
        minuteHandLayer = CALayer()
        minuteHandLayer.backgroundColor = handColor.cgColor
        // Puts the center of the rectangle in the center of the clock
        minuteHandLayer.anchorPoint = CGPoint(x: 0.5, y: 0.039)
        // Positions the hand in the middle of the clock
        minuteHandLayer.position = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        
        // Set size of all hands
        if rect.size.width > rect.size.height {
            hourHandLayer.bounds = CGRect(x: 0, y: 0, width: rect.width/25, height: (rect.size.height / 2) - (rect.size.height * 0.2) - 2)
            minuteHandLayer.bounds = CGRect(x: 0, y: 0, width: rect.width/25, height: (rect.size.height / 2) - 2)
            secondHandLayer.bounds = CGRect(x: 0, y: 0, width: rect.width/40, height: rect.size.height / 2)
        } else {
            hourHandLayer.bounds = CGRect(x: 0, y: 0, width: rect.width/25, height: (rect.size.width / 2) - (rect.size.width * 0.2) - 2)
            minuteHandLayer.bounds = CGRect(x: 0, y: 0, width: rect.width/25, height: (rect.size.width / 2) - 2 )
            secondHandLayer.bounds = CGRect(x: 0, y: 0, width: rect.width/40, height: rect.size.width / 2)
        }
        
        hourHandLayer.cornerRadius = rect.width/50
        minuteHandLayer.cornerRadius = rect.width/50
        secondHandLayer.cornerRadius = rect.width/80
        
        // Add all hand layers to as sublayers
        circleLayer.addSublayer(hourHandLayer)
        circleLayer.addSublayer(minuteHandLayer)
        circleLayer.addSublayer(secondHandLayer)
        
        // Get current hours, minutes and seconds
        var date = Date()
        
        if let customTime = customTime {
            date = customTime
        }
        
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        // Calculate the angles for the each hand
        let hourAngle = CGFloat(hours * (360 / 12)) + CGFloat(minutes) * (1.0 / 60) * (360 / 12)
        let minuteAngle = CGFloat(minutes * (360 / 60))
        let secondsAngle = CGFloat(seconds * (360 / 60))
        
        // Transform the hands according to the calculated angles
        hourHandLayer.transform = CATransform3DMakeRotation(hourAngle / CGFloat(180 * Double.pi), 0, 0, 1)
        minuteHandLayer.transform = CATransform3DMakeRotation(minuteAngle / CGFloat(180 * Double.pi), 0, 0, 1)
        secondHandLayer.transform = CATransform3DMakeRotation(secondsAngle / CGFloat(180 * Double.pi), 0, 0, 1)

        if customTime == nil {
            // Create animation for minutes hand
            let minutesHandAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            // Runs forever
            minutesHandAnimation.repeatCount = Float.infinity
            // One animation (360deg) takes 60 minutes (1 hour)
            minutesHandAnimation.duration = 60 * 60
            minutesHandAnimation.isRemovedOnCompletion = false
            minutesHandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            // From start angle (according to calculated angle from time) plus 360deg which equals 1 rotation
            minutesHandAnimation.fromValue = (minuteAngle + 180) * CGFloat(Double.pi / 180)
            minutesHandAnimation.byValue = 2 * Double.pi
            minuteHandLayer.add(minutesHandAnimation, forKey: "minutesHandAnimation")
            
            // Create animation for hours hand
            let hoursHandAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            // Runs forever
            hoursHandAnimation.repeatCount = Float.infinity
            // One animation (360deg) takes 12 hours
            hoursHandAnimation.duration = CFTimeInterval(60 * 60 * 12);
            hoursHandAnimation.isRemovedOnCompletion = false
            hoursHandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            // From start angle (according to calculated angle from time) plus 360deg which equals 1 rotation
            hoursHandAnimation.fromValue = (hourAngle + 180)  * CGFloat(Double.pi / 180)
            hoursHandAnimation.byValue = 2 * Double.pi
            hourHandLayer.add(hoursHandAnimation, forKey: "hoursHandAnimation")
            
            // Create animation for seconds hand
            let secondsHandAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            // Runs forever
            secondsHandAnimation.repeatCount = Float.infinity
            // One animation (360deg) takes 60 seconds
            secondsHandAnimation.duration = 60
            secondsHandAnimation.isRemovedOnCompletion = false
            secondsHandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            // From start angle (according to calculated angle from time) plus 360deg which equals 1 rotation
            secondsHandAnimation.fromValue = (secondsAngle + 180) * CGFloat(Double.pi / 180)
            secondsHandAnimation.byValue = 2 * Double.pi
            secondHandLayer.add(secondsHandAnimation, forKey: "secondsHandAnimation")
        }
        
    }


}
