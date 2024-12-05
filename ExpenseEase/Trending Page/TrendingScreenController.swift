//
//  TrendingScreenController.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/25/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Charts

class TrendingScreenController: UIViewController {
    
    let currentUser = Auth.auth().currentUser
    var trendingScreen = TrendingScreen()
    var data: [Expense] = []
    var filteredData: [Expense] = []
    var selectedTime: String = "week"
    var categorySpendings = [CategorySpending]()
    let segmentedControlItems: [String] = ["Week", "Month", "Year"]
    var handleAuth: AuthStateDidChangeListenerHandle?
    let database = Firestore.firestore()
    
    override func loadView() {
        view = trendingScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: Observe Firestore database to display the expenses list...
        self.database.collection("users")
            .document((self.currentUser?.email)!)
            .collection("expenses")
            .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.data.removeAll()
                    for document in documents{
                        do{
                            // parse the received document and decode it according to the Contact struct
                            let expense  = try document.data(as: Expense.self)
                            self.data.append(expense)
                        }catch{
                            print(error)
                            print("an error occured when fetching expenses")
                        }
                    }
//                    self.data.sort(by: {$0.amount < $1.amount})
//                    print(self.data)
                    if self.data.count == 0 {
                        self.trendingScreen.lineChart.noDataText = "Add an entry to view trend"
                        self.trendingScreen.categoryExpensePieChart.noDataText = "Add an entry to view trend"
                    } else {
                        // MARK: default to week data upon loading the view
                        self.selectedTime = "week"
                        self.trendingScreen.timeRangeSegControl.selectedSegmentIndex = 0
                        self.filterWeekData()
                        self.setupCategorySpending()
                        let lineChartDataSet = self.setupWeekLineChartData()
                        let weekXLabels = Utilities.daysOfTheWeek.map { String($0.prefix(3)) }
                        self.setupLineChart(lineChartDataSet: lineChartDataSet, xAxisLabels: weekXLabels)
                        // MARK: setup week pie chart data
                        let pieChartDataSet = self.setupPieChartData()
                        self.setupPieChart(pieChartDataSet: pieChartDataSet)
                        // MARK: change total spending label
                        self.setupMainScreenLabels()
    //                    self.trendingScreen.tableViewCategoryExpense.reloadData()
                    }
                    
                }
            })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Overview"
        self.navigationItem.hidesBackButton = true
        trendingScreen.lineChart.delegate = self
        trendingScreen.categoryExpensePieChart.delegate = self
        trendingScreen.tableViewCategoryExpense.delegate = self
        trendingScreen.tableViewCategoryExpense.dataSource = self

    
        // MARK: configure segmented control
        for i in 0...segmentedControlItems.count - 1 {
            trendingScreen.timeRangeSegControl.insertSegment(withTitle: segmentedControlItems[i], at: i, animated: false)
        }
        trendingScreen.timeRangeSegControl.selectedSegmentIndex = 0
        trendingScreen.timeRangeSegControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        

    }
    
    
}
