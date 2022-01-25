//
//  CreditScoreViewController.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 21/01/2022.
//

import UIKit

class CreditScoreViewController: UIViewController, Storyboarded, CreditScoreViewModelProtocol {
    
    @IBOutlet var donutView: DonutView!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    
    lazy var viewModel: CreditScoreViewModel = {
        let vm = CreditScoreViewModel()
        return vm
    }()
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donutViewTapped)))
        
        viewModel.delegate = self
        viewModel.makeCreditCheck()
        
        loadingView.startAnimating()
    }
    
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func creditDataReceived(withResult result: Result<CreditHistory, Error>) {
        DispatchQueue.main.async {
            self.loadingView.stopAnimating()
        }
        switch result {
        case .success(let creditData):
            fillDonutView(creditData: creditData)
        case .failure(let error):
            showErrorAlert(error: error)
        }
    }
    
    @objc func donutViewTapped() {
        guard let creditData = viewModel.creditData else { return }
        coordinator?.showCreditScoreDetails(creditData: creditData)
    }
    
    func fillDonutView(creditData: CreditHistory) {
        DispatchQueue.main.async {
            self.donutView.isHidden = false
            let info = creditData.creditReportInfo
            self.donutView.fillDonutView(score: info.score, outOf: info.maxScoreValue)
        }
    }
}
