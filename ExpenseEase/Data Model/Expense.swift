//
//  Expense.swift
//  ExpenseEaseMainPage
//
//  Created by Muqing Cao on 20/10/24.
//

import Foundation
import UIKit
import FirebaseFirestore

struct Expense: Codable{
    @DocumentID var id: String?
    var amount: Double
    var dateTime: Date
    var category: String
    var note: String?
    var imageUrl: String?
    
    init(amount: Double, dateTime: Date, category: String, note: String? = nil, imageUrl: String? = nil){
        self.amount = amount
        self.dateTime = dateTime
        self.category = category
        self.note = note
        self.imageUrl = imageUrl
    }
}
