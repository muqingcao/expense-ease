//
//  TrendingScreenTableViewManager.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/26/24.
//

import Foundation
import UIKit


extension TrendingScreenController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return categorySpendings.count
        return min(categorySpendings.count, 5)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenses", for: indexPath) as! TableViewSpendingExpenseCell
        cell.labelCategoryName.text = categorySpendings[indexPath.row].category
        cell.labelCategorySpending.text = "$ " + String(format: "%.2f", categorySpendings[indexPath.row].amount)
        cell.labelCategoryPercentage.text =  String(format: "%.0f", categorySpendings[indexPath.row].percentage * 100) + "%"
        cell.imageCategory.image = UIImage(systemName: categorySpendings[indexPath.row].categoryIcon)
        return cell
    }
    
}
