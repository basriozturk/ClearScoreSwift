//
//  DonutView.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 21/01/2022.
//

import UIKit

class DonutView: CustomView {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var outOfLabel: UILabel!
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private let startPoint = CGFloat(-Double.pi / 2)
    private let endPoint = CGFloat(3 * Double.pi / 2)
    
    func createCircularPath() {
        let radius =  frame.size.width / 2.0
        
        // created circularPath for circleLayer and progressLayer
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        
        // ui edits
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 2.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.gray.cgColor
        
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.black.cgColor
        
        // added progressLayer to layer
        layer.addSublayer(self.progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval, progress: CGFloat) {
            // created circularProgressAnimation with keyPath
            let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
            // set the end time
            circularProgressAnimation.duration = duration
            circularProgressAnimation.toValue = progress
            circularProgressAnimation.fillMode = .forwards
            circularProgressAnimation.isRemovedOnCompletion = false
            progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        }
    
    func fillDonutView(score: Int, outOf: Int) {
        createCircularPath()
        scoreLabel.text = String(score)
        outOfLabel.text = "out of " + String(outOf)
        progressAnimation(duration: 1, progress: CGFloat(score) / CGFloat(outOf))
    }
    
}
