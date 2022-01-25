//
//  MainCoordinator.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 24/01/2022.
//

import Foundation
import UIKit

class MainCoordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = CreditScoreViewController.instantiate(fromStoryboard: .Main)
        vc.coordinator = self
        navigationController.title = AppConstants.DashboardNavTitle
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showCreditScoreDetails(creditData: CreditHistory) {
        let vc = DetailsViewController.instantiate(fromStoryboard: .Main)
        vc.coordinator = self
        vc.creditData = creditData
        navigationController.title = AppConstants.ScoreDetailsNavTitle
        navigationController.pushViewController(vc, animated: true)
    }
}
