//
//  TrendingScreenWeekDataManager.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/26/24.
//

import Foundation
import Charts

extension TrendingScreenController {
    func filterWeekData(){
        filteredData = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentWeek = Utilities.getCurrentWeekDates()
        for expense in data {
            // MARK: extract expense date attribute
            var date = expense.dateTime
            var formattedDate = dateFormatter.string(from: date)
            if currentWeek.keys.contains(formattedDate) {
                filteredData.append(expense)
            }
        }
    }
    
    func setupWeekLineChartData() -> LineChartDataSet{
        var lineChartDataEntries: [ChartDataEntry] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentWeek = Utilities.getCurrentWeekDates()
        var dayToAmount: [String: Double] = [:]
        for expense in filteredData {
            // MARK: extract expense date attribute
            var date = expense.dateTime
            var formattedDate = dateFormatter.string(from: date)
            // MARK: group expenses by day of week
            if currentWeek.keys.contains(formattedDate) {
                var dayOfWeek = currentWeek[formattedDate]
                if let unwrappedDayOfWeek = dayOfWeek {
                    if dayToAmount.keys.contains(unwrappedDayOfWeek) {
                        dayToAmount[unwrappedDayOfWeek]! += expense.amount
                    } else {
                        dayToAmount[unwrappedDayOfWeek] = expense.amount
                    }
                }
            }
        }
        
        for d in 0...Utilities.daysOfTheWeek.count - 1{
            var day = Utilities.daysOfTheWeek[d]
            if dayToAmount.keys.contains(day) {
                if let unwrappedAmount = dayToAmount[day]{
                    var chartDataEntry = ChartDataEntry(x: Double(d), y: unwrappedAmount, data: day)
                    lineChartDataEntries.append(chartDataEntry)
                }
            } else {
                lineChartDataEntries.append(ChartDataEntry(x: Double(d), y:0.00, data: day))
            }
        }
        return LineChartDataSet(entries: lineChartDataEntries)
    }
    
}
