//
//  CreditScoreViewModel.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 21/01/2022.
//

import Foundation

class CreditScoreViewModel {
    
    weak var delegate: CreditScoreViewModelProtocol?
    
    var creditData: CreditHistory?
    var apiClient: APIClientProtocol
    
    init() {
        apiClient = CreditDataClient()
    }
    
    func makeCreditCheck() {
        apiClient.getCreditData { result in
            switch result {
            case .success(let creditData):
                self.creditData = creditData
                self.delegate?.creditDataReceived(withResult: .success(creditData))
            case .failure(let error):
                self.delegate?.creditDataReceived(withResult: .failure(error))
            }
        }
    }
}

protocol CreditScoreViewModelProtocol: AnyObject {
    func creditDataReceived(withResult result: Result<CreditHistory, Error>)
}
