//
//  CategorySpending.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/26/24.
//

import Foundation

struct CategorySpending {
    var amount: Double
    var category: String
    var categoryIcon: String
    var percentage: Double
    
    init(amount: Double, category: String, categoryIcon: String, percentage: Double) {
        self.amount = amount
        self.category = category
        self.categoryIcon = categoryIcon
        self.percentage = percentage
    }
}
