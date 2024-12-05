//
//  TrendingScreenYearDataManager.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/26/24.
//

import Foundation
import Charts

extension TrendingScreenController {
    func setupYearLineChartData() -> LineChartDataSet {
        var lineChartDataEntries: [ChartDataEntry] = []
        var monthToAmount: [Int: Double] = [:]
        let date = Date()
        let calendar = Calendar.current
        for expense in data {
            // MARK: extract expense date attribute
            var month = calendar.component(.month, from: expense.dateTime)
            // MARK: group expenses by day of week
            if monthToAmount.keys.contains(month) {
                monthToAmount[month]! += expense.amount
            } else {
                monthToAmount[month] = expense.amount
            }
        }
        for m in 1...12 {
            if monthToAmount.keys.contains(m) {
                if let unwrappedAmount = monthToAmount[m] {
                    var chartDataEntry = ChartDataEntry(x: Double(m), y: unwrappedAmount, data: Utilities.monthsOfTheYear[m - 1])
                    lineChartDataEntries.append(chartDataEntry)
                }
            } else {
                var chartDataEntry = ChartDataEntry(x: Double(m), y: 0, data: Utilities.monthsOfTheYear[m - 1])
                lineChartDataEntries.append(chartDataEntry)
            }
            
            
        }
        return LineChartDataSet(entries: lineChartDataEntries)
    }

}
