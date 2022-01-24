//
//  CreditScoreViewController.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 21/01/2022.
//

import UIKit

class CreditScoreViewController: UIViewController, CreditScoreViewModelProtocol {
    
    @IBOutlet var donutView: DonutView!
    @IBOutlet var loadingView: UIActivityIndicatorView!
    
    lazy var viewModel: CreditScoreViewModel = {
        let vm = CreditScoreViewModel()
        return vm
    }()
    
    var creditData: CreditHistory?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = AppConstants.DashboardNavTitle
        donutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donutViewTapped)))
        
        viewModel.delegate = self
        
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
            self.creditData = creditData
            fillDonutView(creditData: creditData)
        case .failure(let error):
            showErrorAlert(error: error)
        }
    }

    @objc func donutViewTapped() {
        if let creditData = creditData {
            let storyboard = UIStoryboard(name: AppConstants.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: AppConstants.DetailsSID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func fillDonutView(creditData: CreditHistory) {
        DispatchQueue.main.async {
            self.donutView.isHidden = false
            let info = creditData.creditReportInfo
            self.donutView.fillDonutView(score: info.score, outOf: info.maxScoreValue)
        }
    }
}
