//
//  User.swift
//  ExpenseEaseMainPage
//
//  Created by Muqing Cao on 16/11/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable{
    @DocumentID var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var photoUrl: String?
    var expenses: [Expense]?
    
    init(firstName: String, lastName: String, email: String, photoUrl: String, expenses: [Expense]? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.photoUrl = photoUrl
        self.expenses = expenses
    }
}
