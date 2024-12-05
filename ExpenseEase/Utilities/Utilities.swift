//
//  Utilities.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/25/24.
//

import Foundation
import UIKit

class Utilities {
    
    static func validateEmail(_ enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    static func showErrorAlert(_ text: String, _ message: String) -> UIAlertController{
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    static func getCurrentWeekDates() -> [String: String] {
        var weekDates: [String: String] = [:]
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        
        // Get today's date
        let today = Date()
        
        // Find the weekday index of today (1 = Sunday, 7 = Saturday)
        let weekdayIndex = calendar.component(.weekday, from: today)
        
        // Calculate the start of the week (Sunday by default)
        guard let startOfWeek = calendar.date(byAdding: .day, value: -(weekdayIndex - 1), to: today) else { return [:] }
        
        // Loop through the week (Sunday to Saturday)
        for offset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek) {
                let formattedDate = dateFormatter.string(from: date)
                let formattedDay = dayFormatter.string(from: date)
                weekDates[formattedDate] = formattedDay
            }
        }
        
        return weekDates
    }
    
    
    static let daysOfTheWeek: [String] = ["Sunday",
                                          "Monday",
                                          "Tuesday",
                                          "Wednesday",
                                          "Thursday",
                                          "Friday",
                                          "Saturday"]
    
    static let monthsOfTheYear: [String] = ["January",
                                            "February",
                                            "March",
                                            "April",
                                            "May",
                                            "June",
                                            "July",
                                            "August",
                                            "September",
                                            "October",
                                            "November",
                                            "December"]
    
    static let categoriesImages: [String: String] = [
        "Restaurant": "fork.knife",
        "Grocery": "cart",
        "Housing": "house",
        "Social": "figure.socialdance",
        "Fitness": "dumbbell",
        "Gas": "fuelpump",
        "Clothing": "tshirt",
        "Utilities": "lightbulb",
        "Electronics": "tv",
        "Transport": "car",
        "Travel": "airplane",
        "Health": "cross.case",
        "Entertainment": "gamecontroller",
        "Gifts": "gift",
        "Education": "book"
    ]
    
    static let monthsWith30Days: Set<Int> = [
        4,6,9,11
    ]
}
