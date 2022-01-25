//
//  MockAPIClient.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 24/01/2022.
//

import Foundation

final class MockAPIClient: APIClientProtocol {
    
    func getCreditData(_ completion: @escaping (Result<CreditHistory, Error>) -> Void) {
        if let jsonPath = Bundle.main.url(forResource: "data", withExtension: "json") {
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(CreditHistory.self, from: Data(contentsOf: jsonPath))
                completion(.success(decoded))
            }
            catch {
                completion(.failure(APICallErrors.decodingError))
            }
        }
        else {
            fatalError("Couldn't find the file in main bundle")
        }
        
    }
}
