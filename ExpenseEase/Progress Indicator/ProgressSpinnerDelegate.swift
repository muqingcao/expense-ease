//
//  ProgressSpinnerDelegate.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 12/2/24.
//

import Foundation

// Any class that wants to display the progress indicator view
// must adopt this protocol and define the following methods
protocol ProgressSpinnerDelegate{
    func showActivityIndicator()
    func hideActivityIndicator()
}
