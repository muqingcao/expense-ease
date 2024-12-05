//
//  TrendingScreenChartManager.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/26/24.
//

import Foundation
import Charts

extension TrendingScreenController: ChartViewDelegate {
    
    @objc func indexChanged(_ segmentedControl: UISegmentedControl) {
//        print(segmentedControlItems[segmentedControl.selectedSegmentIndex])
        if data.count == 0 {
            trendingScreen.lineChart.noDataText = "Add an entry to view trend"
            trendingScreen.categoryExpensePieChart.noDataText = "Add an entry to view trend"
            return
        }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // MARK: week is selected
            selectedTime = "week"
            filterWeekData()
            setupCategorySpending()
            let lineChartDataSet = setupWeekLineChartData()
            let weekXLabels = Utilities.daysOfTheWeek.map { String($0.prefix(3)) }
            setupLineChart(lineChartDataSet: lineChartDataSet, xAxisLabels: weekXLabels)
            // MARK: setup week pie chart data
            let pieChartDataSet = setupPieChartData()
            setupPieChart(pieChartDataSet: pieChartDataSet)
            // MARK: change total spending label
            setupMainScreenLabels()
            resetPieChartHighlights()
            break
        case 1:
            // MARK: month is selected
            selectedTime = "month"
            filterMonthData()
            setupCategorySpending()
            let lineChartDataSet = setupMonthLineChartData()
            let monthXLabels = setupMonthLineChartXLabels()
            setupLineChart(lineChartDataSet: lineChartDataSet, xAxisLabels: monthXLabels)
            // MARK: setup month pie chart data
            let pieChartDataSet = setupPieChartData()
            setupPieChart(pieChartDataSet: pieChartDataSet)
            // MARK: change total spending label
            setupMainScreenLabels()
            resetPieChartHighlights()
            break
        case 2:
            // MARK: year is selected
            selectedTime = "year"
            filteredData = data
            setupCategorySpending()
            let lineChartDataSet = setupYearLineChartData()
            let yearXLabels = Utilities.monthsOfTheYear.map { String($0.prefix(3)) }
            setupLineChart(lineChartDataSet: lineChartDataSet, xAxisLabels: yearXLabels)
            let pieChartDataSet = setupPieChartData()
            setupPieChart(pieChartDataSet: pieChartDataSet)
            // MARK: change total spending label
            setupMainScreenLabels()
            resetPieChartHighlights()
            break
        default:
            break
        }
    }
    


    func setupLineChart(lineChartDataSet: LineChartDataSet, xAxisLabels: [String]) {
        // MARK: customize dataset appearance
//            lineChartDataSet.colors = ChartColorTemplates.joyful()
        lineChartDataSet.drawFilledEnabled = true
        lineChartDataSet.fillColor = UIColor(red: 0.00, green: 0.30, blue: 0.81, alpha: 1.00)
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.colors = [.systemBlue]
        lineChartDataSet.lineWidth = 1.5
        
        //MARK: set up  highlight markers
        lineChartDataSet.highlightColor = UIColor(red: 0.91, green: 0.34, blue: 0.04, alpha: 0.7)
        // Highlight line color
        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = true
        lineChartDataSet.drawVerticalHighlightIndicatorEnabled = true
        lineChartDataSet.highlightLineWidth = 2


        //MARK: set line chart data
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartData.setDrawValues(false)
        trendingScreen.lineChart.data = lineChartData
        

        //MARK: set up x labels for line chart
        trendingScreen.lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisLabels)
        
    }
    
    func setupPieChart(pieChartDataSet: PieChartDataSet){
        pieChartDataSet.colors = ChartColorTemplates.joyful()
        pieChartDataSet.entryLabelColor = .black
//        pieChartDataSet.yValuePosition = .outsideSlice

        let pieChartData = PieChartData(dataSet: pieChartDataSet)
//        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: createPercentageFormatter()))
        pieChartData.setValueFont(.systemFont(ofSize: 18))
        pieChartData.setValueTextColor(.black)
        trendingScreen.categoryExpensePieChart.data = pieChartData
//        trendingScreen.categoryExpensePieChart.drawEntryLabelsEnabled = true
//        trendingScreen.categoryExpensePieChart.usePercentValuesEnabled = true
//        trendingScreen.categoryExpensePieChart.notifyDataSetChanged()
        // Set a value formatter to display percentages
        let percentageFormatter = DefaultValueFormatter(formatter: createPercentageFormatter())
        pieChartDataSet.valueFormatter = percentageFormatter
    }

    func setupPieChartData() -> PieChartDataSet{
        // MARK: set up data for pie chart
        var pieChartDataEntries: [PieChartDataEntry] = []
        // MARK: construct pie chart data entries
        for cs in categorySpendings {
            pieChartDataEntries.append(PieChartDataEntry(value: cs.amount, label: cs.category))
        }
        let pieChartDataSet = PieChartDataSet(pieChartDataEntries)

        return pieChartDataSet
    }
    
    func setupCategorySpending() {
        categorySpendings = []
        var categoryToAmount: [String: Double] = [:]
        var total = 0.00
        for expense in filteredData {
            if categoryToAmount.keys.contains(expense.category) {
                categoryToAmount[expense.category]! += expense.amount
            } else {
                categoryToAmount[expense.category] = expense.amount
            }
            total += expense.amount
        }
        for (category, amount) in categoryToAmount {
            var categoryIcon = Utilities.categoriesImages[category]
            if let unwrappedCategoryIcon = categoryIcon {
                categorySpendings.append(CategorySpending(amount: amount, category: category, categoryIcon: unwrappedCategoryIcon, percentage: amount / total))
            }
        }
        categorySpendings.sort(by: {$0.amount > $1.amount})
        trendingScreen.tableViewCategoryExpense.reloadData()
    }
    
    func createPercentageFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
//        formatter.positiveSuffix = "%"
        return formatter
    }

    
    func calculateTotalSpending() -> Double{
        var totalSpending = 0.00
        for expense in filteredData {
            totalSpending += expense.amount
        }
        return totalSpending
    }
    
    func setupMainScreenLabels() {
        trendingScreen.labelSpending.text = "This \(selectedTime) you spent"
        trendingScreen.labelTotal.text = "$ " + String(format: "%.2f", calculateTotalSpending())
        trendingScreen.labeltopFive.text = "Top 5 Spending This \(selectedTime.capitalized)"
    }
    
    func resetPieChartHighlights() {
        trendingScreen.categoryExpensePieChart.highlightValues(nil)
        trendingScreen.categoryExpensePieChart.centerAttributedText = nil
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        NSLog("chartValueSelected");
        if chartView is LineChartView {
            var labelSpendingText = ""
            if let data = entry.data as? String {
                if Utilities.daysOfTheWeek.contains(data) {
                    labelSpendingText = "On " + data + " you spent"
                } else if Utilities.monthsOfTheYear.contains(data) {
                    labelSpendingText = "In  " + data + "  you spent"
                }
            }else if let data = entry.data as? Int{
                let date = Date()
                let calendar = Calendar.current
                let month = calendar.component(.month, from: date)
                labelSpendingText = "On  \(Utilities.monthsOfTheYear[month - 1]) \(String(data)), 2024" + "  you spent"
            }
            trendingScreen.labelSpending.text = labelSpendingText
            trendingScreen.labelTotal.text = "$ " + String(format: "%.2f", entry.y)
        } else {
            let entry = entry as? PieChartDataEntry
            if let unwrappedEntry = entry {
                if let data = unwrappedEntry.label {
                    let displayString = data + "  $\(String(format: "%.2f", unwrappedEntry.value))"
                    trendingScreen.categoryExpensePieChart.centerAttributedText = NSAttributedString(string: displayString, attributes: [
                        .font: UIFont.systemFont(ofSize: 17)])
                }
            }
            
            
        }
        
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
        trendingScreen.lineChart.highlightValue(nil)
        resetPieChartHighlights()
        setupMainScreenLabels()
        
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
}
