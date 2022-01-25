//
//  Storyboarded.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 24/01/2022.
//

import Foundation
import UIKit

enum StoryboardHelper : String {
    
    case Main
    
    var instance : UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

protocol Storyboarded {
    
    static func instantiate(fromStoryboard storyboardHelper: StoryboardHelper) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(fromStoryboard storyboardHelper: StoryboardHelper) -> Self {
        return storyboardHelper.instance.instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}
