//
//  CreditHistoryViewModelTests.swift
//  ClearScoreInterviewTests
//
//  Created by Hasan Basri Ozturk on 24/01/2022.
//

import XCTest
@testable import ClearScoreInterview

class CreditScoreViewModelTests: XCTestCase {

    var mockAPIService: APIClientProtocol!
    var viewModel: CreditScoreViewModel!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIClient()
        viewModel = CreditScoreViewModel()
        viewModel.apiClient = mockAPIService
    }

    override func tearDown() {
        mockAPIService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testCreditCheck() {
        viewModel.makeCreditCheck()
        
        XCTAssertFalse(viewModel.creditData == nil)
    }
}
