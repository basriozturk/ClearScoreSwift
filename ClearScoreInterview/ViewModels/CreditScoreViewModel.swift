//
//  CreditScoreViewModel.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 21/01/2022.
//

import Foundation

class CreditScoreViewModel {
    
    weak var delegate: CreditScoreViewModelProtocol?
    
    var creditHistory: CreditHistory?
    
    init() {
        makeCreditCheck()
    }
    
    func makeCreditCheck() {
        CreditDataClient.getCreditData { result in
            switch result {
            case .success(let creditHistory):
                self.delegate?.creditDataReceived(withResult: .success(creditHistory))
            case .failure(let error):
                self.delegate?.creditDataReceived(withResult: .failure(error))
            }
        }
    }
}

protocol CreditScoreViewModelProtocol: AnyObject {
    func creditDataReceived(withResult result: Result<CreditHistory, Error>)
}
