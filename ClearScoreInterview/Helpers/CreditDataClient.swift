//
//  CreditDataClient.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 21/01/2022.
//

import Foundation

class CreditDataClient {
    
    private static func fetchCreditData(_ completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: AppConstants.APIEndpoint){
            let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            task.resume()
        }
    }
    
    static func getCreditData(_ completion: @escaping (Result<CreditHistory, Error>) -> Void) {
        fetchCreditData { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(CreditHistory.self, from: data)
                    completion(.success(decoded))
                }
                catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
}
