//
//  CreditHistory.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 21/01/2022.
//

import Foundation

struct CreditHistory: Codable {
    
    let accountIDVStatus: String
    let creditReportInfo: CreditReportInfo
    let dashboardStatus: String
    let personaType: String
    let coachingSummary: CoachingSummary
    var augmentedCreditScore: Int?
   
}
