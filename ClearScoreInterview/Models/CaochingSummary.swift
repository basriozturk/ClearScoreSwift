//
//  CaochingSummary.swift
//  ClearScoreInterview
//
//  Created by Hasan Basri Ozturk on 21/01/2022.
//

import Foundation

struct CoachingSummary: Codable {
    
    let activeTodo: Bool
    let activeChat: Bool
    let numberOfTodoItems: Int
    let numberOfCompletedTodoItems: Int
    let selected: Bool
    
}
