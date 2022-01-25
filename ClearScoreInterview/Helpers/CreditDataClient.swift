//
//  CreditDataClient.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 21/01/2022.
//

import Foundation

final class CreditDataClient: APIClientProtocol {
    
    func getCreditData(_ completion: @escaping (Result<CreditHistory, Error>) -> Void) {
        fetchCreditData(urlString: AppConstants.APIEndpoint) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(CreditHistory.self, from: data)
                    completion(.success(decoded))
                }
                catch {
                    completion(.failure(APICallErrors.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}

protocol APIClientProtocol {
    func getCreditData(_ completion: @escaping (Result<CreditHistory, Error>) -> Void)
    func fetchCreditData(urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void)
}

extension APIClientProtocol {
    func fetchCreditData(urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if error != nil {
                    completion(.failure(APICallErrors.dataTaskError))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            task.resume()
        }
    }
}

enum APICallErrors: Error, Equatable {
    case dataTaskError
    case decodingError
}
