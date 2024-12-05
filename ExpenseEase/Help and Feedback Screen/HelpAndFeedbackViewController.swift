//
//  HelpAndFeedbackViewController.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 10/29/24.
//

import UIKit

class HelpAndFeedbackViewController: UIViewController {
    let helpAndFeebackScreen = HelpAndFeedbackView()
    
    override func loadView() {
        view = helpAndFeebackScreen
        title = "Help and Feedback"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
}
