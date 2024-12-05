//
//  TrendingScreenMonthDataManager.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/26/24.
//

import Foundation
import Charts


extension TrendingScreenController {
    func filterMonthData(){
        filteredData = []
        let date = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: date)
        for expense in data {
            // MARK: extract expense date attribute
            var expenseMonth = calendar.component(.month, from: expense.dateTime)
            if expenseMonth == currentMonth {
                filteredData.append(expense)
            }
        }
    }
    
    func setupMonthLineChartData() -> LineChartDataSet{
        var lineChartDataEntries: [ChartDataEntry] = []
        var dayToAmount: [Double: Double] = [:]
        let calendar = Calendar.current
        for expense in filteredData {
            // MARK: extract expense date attribute
            var day = Double(calendar.component(.day, from: expense.dateTime))
            // MARK: group expenses by day of week
            if dayToAmount.keys.contains(day) {
                dayToAmount[day]! += expense.amount
            } else {
                dayToAmount[day] = expense.amount
            }
        }
        var endDay = self.generateEndDay()
        for i in 1...endDay {
            var doubleI = Double(i)
            if dayToAmount.keys.contains(doubleI) {
                if let unwrappedAmount = dayToAmount[doubleI]{
                    var chartDataEntry = ChartDataEntry(x: doubleI, y: unwrappedAmount, data: i)
                    lineChartDataEntries.append(chartDataEntry)
                }
            } else {
                var chartDataEntry = ChartDataEntry(x:doubleI, y: 0, data: i)
                lineChartDataEntries.append(chartDataEntry)
            }
        }
        return LineChartDataSet(entries: lineChartDataEntries)
    }
    
    func setupMonthLineChartXLabels() -> [String] {
        var monthXLabels: [String] = []
        var endDay = self.generateEndDay()
        for i in 1...endDay {
            monthXLabels.append(String(i))
        }
        return monthXLabels
    }
    
    func generateEndDay() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: Date())
        if let unwrappedInterval = interval {
            return calendar.component(.day, from: unwrappedInterval.end.advanced(by: -10))
        }
        return 31
    }
    
}

