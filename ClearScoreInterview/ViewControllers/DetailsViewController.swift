//
//  DetailsViewController.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 24/01/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        lazy var viewModel: DetailsViewModel = {
            let vm = DetailsViewModel()
            return vm
        }()
    }
    
    

}
