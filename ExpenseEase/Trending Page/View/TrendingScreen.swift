//
//  TrendingScreen.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/25/24.
//

import UIKit
import Charts

class TrendingScreen: UIView {
    
    var contentWrapper: UIScrollView!
    var labelSpending: UILabel!
    var labelTotal: UILabel!
    var timeRangeSegControl: UISegmentedControl!
    var lineChart: LineChartView!
    var categoryExpensePieChart: PieChartView!
    var tableViewCategoryExpense: UITableView!
    var labeltopFive: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupTimeRangeSegControl()
        setupLabelSpending()
        setupLabelTotal()
        setupLineChart()
        setupCategoryExpensePieChart()
        setupLabelTopFive()
        setupTableViewCategoryExpense()
        initConstraints()
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.isScrollEnabled = true
        contentWrapper.showsVerticalScrollIndicator = true
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupLabelSpending() {
        labelSpending = UILabel()
        labelSpending.text = "This week you spent"
        labelSpending.font = UIFont.systemFont(ofSize: 20)
        labelSpending.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelSpending)
    }
    
    func setupLabelTotal() {
        labelTotal = UILabel()
        labelTotal.text = "$ 0.00"
        labelTotal.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        labelTotal.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelTotal)
    }
    
    func setupTimeRangeSegControl() {
        timeRangeSegControl = UISegmentedControl()
        timeRangeSegControl.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(timeRangeSegControl)
    }
    
    
    func setupLineChart() {
        lineChart = LineChartView()
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.legend.enabled = false
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.axisMinimum = 0
        lineChart.leftAxis.labelFont = .systemFont(ofSize: 14)
        lineChart.animate(yAxisDuration: 2)
        lineChart.setScaleEnabled(false)
//        monthlyExpenseLineChart.highlightPerTapEnabled = true
        
        // MARK: configure line chart x-labels
        lineChart.xAxis.granularity = 1
        lineChart.xAxis.labelFont = .systemFont(ofSize: 13)
        lineChart.xAxis.labelPosition = .bottom
        contentWrapper.addSubview(lineChart)
    }
    
    func setupCategoryExpensePieChart() {
        categoryExpensePieChart = PieChartView()
        categoryExpensePieChart.usePercentValuesEnabled = true
        categoryExpensePieChart.legend.enabled = false
        categoryExpensePieChart.drawEntryLabelsEnabled = false
        // set text displayed inside the pie chart hole
//        categoryExpensePieChart.centerAttributedText = NSAttributedString("Hi")
        categoryExpensePieChart.animate(xAxisDuration: 2, easingOption: .easeOutBack)
        categoryExpensePieChart.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(categoryExpensePieChart)
    }
    
    func setupLabelTopFive() {
        labeltopFive = UILabel()
//        labeltopFive.text = "Top 5 Spendings"
        labeltopFive.font = UIFont.systemFont(ofSize: 28)
        labeltopFive.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labeltopFive)
    }
    
    func setupTableViewCategoryExpense() {
        tableViewCategoryExpense = UITableView()
        tableViewCategoryExpense.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        tableViewCategoryExpense.register(TableViewSpendingExpenseCell.self, forCellReuseIdentifier: "expenses")
        tableViewCategoryExpense.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(tableViewCategoryExpense)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            timeRangeSegControl.topAnchor.constraint(equalTo: contentWrapper.topAnchor),
            timeRangeSegControl.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            timeRangeSegControl.widthAnchor.constraint(equalToConstant: 300),
           
            
            labelSpending.topAnchor.constraint(equalTo: timeRangeSegControl.bottomAnchor, constant: 25),
            labelSpending.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            labelTotal.topAnchor.constraint(equalTo: labelSpending.bottomAnchor, constant: 10),
            labelTotal.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            lineChart.topAnchor.constraint(equalTo: labelTotal.bottomAnchor, constant: 20),
            lineChart.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            lineChart.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 10),
            lineChart.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -10),
            lineChart.heightAnchor.constraint(equalToConstant: 300),

            categoryExpensePieChart.topAnchor.constraint(equalTo: lineChart.bottomAnchor, constant: 30),
            categoryExpensePieChart.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            categoryExpensePieChart.widthAnchor.constraint(equalTo: contentWrapper.widthAnchor),
            categoryExpensePieChart.heightAnchor.constraint(equalToConstant: 375),
            
            labeltopFive.topAnchor.constraint(equalTo: categoryExpensePieChart.bottomAnchor, constant: 30),
            labeltopFive.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            tableViewCategoryExpense.topAnchor.constraint(equalTo: labeltopFive.bottomAnchor),
            tableViewCategoryExpense.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 30),
            tableViewCategoryExpense.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -30),
            tableViewCategoryExpense.heightAnchor.constraint(equalToConstant: 500),
            tableViewCategoryExpense.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
