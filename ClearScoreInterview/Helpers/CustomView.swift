//
//  CustomView.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 22/01/2022.
//

import Foundation
import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let bundle = Bundle(for: type(of: self))
        
        let fullName = NSStringFromClass(Self.self)
        let className = fullName.components(separatedBy: ".")[1]
        
        if let result = bundle.loadNibNamed(className, owner: self, options: nil) {
            for item in result {
                if let contentView = item as? UIView {
                    addSubview(contentView)
                    contentView.frame = self.bounds
                    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                    
                    break
                }
            }
        }
    }
    
}

