//
//  PrivatePolicyViewController.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 10/29/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PrivatePolicyViewController: UIViewController {
    
    let privatePolicyScreen = PrivatePolicyView()
  
    
    override func loadView() {
        view = privatePolicyScreen
        title = "ExpenseEase"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}
