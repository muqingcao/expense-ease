//
//  ProgressSpinnerViewController.swift
//  ExpenseEase
//
//  Created by Guangmei Xiang on 12/2/24.
//

import UIKit

class ProgressSpinnerViewController: UIViewController {

    
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .orange
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        // when this indicator view is loaded, start the "loading" animation
        activityIndicator.startAnimating()
        
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }

}
