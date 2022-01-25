//
//  APIClientTests.swift
//  ClearScoreInterviewTests
//
//  Created by Hasan Basri Ozturk on 24/01/2022.
//

import XCTest
@testable import ClearScoreInterview

class APIClientTests: XCTestCase {
    
    var apiClient: CreditDataClient!
    var mockAPIClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        apiClient = CreditDataClient()
        mockAPIClient = MockAPIClient()
    }
    
    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }
    
    func testCreditHistoryModel() {
        let jsonPath = Bundle.main.url(forResource: "data", withExtension: "json")
        do {
            if let jsonPath = jsonPath {
                let data = try Data(contentsOf: jsonPath)
                let creditData = try JSONDecoder().decode(CreditHistory.self, from: data)
                XCTAssertEqual(creditData.accountIDVStatus, "PASS")
            }
            else {
                XCTFail("data.json file does not exist.")
            }
        }
        catch {
            XCTFail("json data is not valid.")
        }
    }
    
    func testSuccessfulFetchCreditData() {
        let jsonPath = Bundle.main.url(forResource: "data", withExtension: "json")
        do {
            if let jsonPath = jsonPath {
                let expectedData = try Data(contentsOf: jsonPath)
                apiClient.fetchCreditData(urlString: AppConstants.APIEndpoint) { result in
                    switch result {
                    case .success(let data):
                        XCTAssertEqual(data, expectedData)
                    case .failure(let error):
                        XCTFail("fetch failed when it was supposed to succeed \(error.localizedDescription)")
                    }
                }
            }
            else {
                XCTFail("data.json file does not exist.")
            }
        }
        catch {
            XCTFail("json data is not valid.")
        }
    }
    
    func testFailedFetchCreditData() {
        apiClient.fetchCreditData(urlString: "") { result in
            switch result {
            case .success(_):
                XCTFail("fetch succeeded when it was supposed to fail")
            case .failure(let error):
                XCTAssertTrue(error is APICallErrors, "unexpected error type")
                XCTAssertEqual(error as! APICallErrors, APICallErrors.dataTaskError)
            }
        }
    }
    
    func testSuccessfulGetCreditData() {
        apiClient.getCreditData { result in
            switch result {
            case .success(let creditData):
                XCTAssertEqual(creditData.accountIDVStatus, "PASS")
            case .failure(let error):
                XCTFail("get failed when it was supposed to succeed \(error.localizedDescription)")
            }
        }
    }
}
