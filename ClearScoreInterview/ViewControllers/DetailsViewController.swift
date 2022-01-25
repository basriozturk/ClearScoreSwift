//
//  DetailsViewController.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 24/01/2022.
//

import UIKit

class DetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var scoreBandLabel: UILabel!
    @IBOutlet var bottomContentView: UIView!
    @IBOutlet var creditDisplayCard: UIView!
    @IBOutlet var creditLimitLabel: UILabel!
    @IBOutlet var creditLabel: UILabel!
    @IBOutlet var creditProgress: UIProgressView!
    
    lazy var viewModel: DetailsViewModel = {
        let vm = DetailsViewModel()
        return vm
    }()
    
    var creditData: CreditHistory!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
        startUIAnimations()
    }
    
    func initializeUI() {
        scoreBandLabel.text =  creditData.creditReportInfo.equifaxScoreBandDescription
        scoreLabel.text = String(creditData.creditReportInfo.score)
        
        creditProgress.setProgress(0, animated: false)
        
        creditLimitLabel.text = "£ " +  String(creditData.creditReportInfo.currentShortTermCreditLimit)
        creditLabel.text = "£ " +  String(creditData.creditReportInfo.currentShortTermDebt)
        
        creditDisplayCard.addShadow(cornerRadius: 10)
        
        bottomContentView.alpha = 0
    }
    
    func startUIAnimations() {
        let cardAnim = {
            UIView.animate(withDuration: 1, animations: {
                self.creditProgress.setProgress( Float(self.creditData.creditReportInfo.currentShortTermCreditUtilisation) / Float(100), animated: true)
            })
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.bottomContentView.alpha = 1.0
        }, completion: { success in
            if success {
                cardAnim()
            }
        })
    }
    
}
