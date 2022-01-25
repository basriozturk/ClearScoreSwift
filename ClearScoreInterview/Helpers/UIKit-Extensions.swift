//
//  UIKit-Extensions.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 24/01/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(cornerRadius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .init(width: 1, height: 1)
        layer.shadowRadius = cornerRadius
        layer.cornerRadius = cornerRadius
    }
}
