//
//  EditExpenseView.swift
//  ExpenseEase
//
//  Created by Xihuan Liu on 11/18/24.
//

import UIKit

class EditExpenseView: AddExpenseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        uploadLabel.text = "Change receipt"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

