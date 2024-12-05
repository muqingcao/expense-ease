//
//  CategoryGridManager.swift
//  ExpenseEase
//
//  Created by Xihuan Liu on 11/12/24.
//

import UIKit

extension AddExpenseViewController {
    func setupCategoryButtons() {
        let titles = Categories.categoryTitles
        let imageNames = Categories.categoryIconImageNames
        
        let gridStackView = createCategoryGrid(titles: titles, imageNames: imageNames)
                
        addExpenseView.categoriesStackView.addArrangedSubview(gridStackView)
    }
    
    func createCategoryGrid(titles: [String], imageNames: [String]) -> UIStackView {
        let numberOfColumns = 5
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill  // same col width
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        var currentRowStackView = UIStackView()
        currentRowStackView.axis = .horizontal
        currentRowStackView.spacing = 16
        currentRowStackView.distribution = .fillEqually

        for (index, title) in titles.enumerated() {
            // icon button
            let iconButton = UIButton()
            let iconImage = UIImage(systemName: imageNames[index])
            iconButton.setImage(iconImage, for: .normal)
            iconButton.tintColor = .black
            iconButton.translatesAutoresizingMaskIntoConstraints = false
            iconButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            iconButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            iconButton.tag = index
            
            // add shadow and boarder
            iconButton.layer.shadowColor = UIColor.gray.cgColor
            iconButton.layer.shadowOpacity = 0.3
            iconButton.layer.shadowRadius = 4
            iconButton.layer.shadowOffset = CGSize(width: 0, height: 4)
            iconButton.layer.cornerRadius = iconButton.frame.height / 2
            iconButton.layer.masksToBounds = false
            
            // save to categoryButtons
            categoryButtons.append(iconButton)
            iconButton.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)

            // label
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 10)
            label.textAlignment = .center
            label.numberOfLines = 0 // allow multiline

            // vertical stack for each item
            let verticalStack = UIStackView(arrangedSubviews: [iconButton, label])
            verticalStack.axis = .vertical
            verticalStack.alignment = .center
            verticalStack.spacing = 4
            verticalStack.distribution = .fill

            currentRowStackView.addArrangedSubview(verticalStack)

            // row complete, add to main stack and start a new row
            if (index + 1) % numberOfColumns == 0 {
                stackView.addArrangedSubview(currentRowStackView)
                currentRowStackView = UIStackView()
                currentRowStackView.axis = .horizontal
                currentRowStackView.spacing = 16
                currentRowStackView.distribution = .fillEqually
            }
        }

        // If last row with less than 5 items, add empty views to fill the row
        let remainingItems = currentRowStackView.arrangedSubviews.count
        if remainingItems > 0 && remainingItems < numberOfColumns {
            for _ in remainingItems..<numberOfColumns {
                let emptyView = UIView()
                currentRowStackView.addArrangedSubview(emptyView)
            }
            stackView.addArrangedSubview(currentRowStackView)
        }

        return stackView
    }
    
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        selectedCategory = Categories.categoryTitles[sender.tag]
        
        // reset button format
        for button in categoryButtons {
            button.transform = .identity
            button.layer.shadowOffset = CGSize(width: 0, height: 4)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.clear.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
        
        // maked selected button smaller
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            sender.layer.shadowOffset = CGSize(width: 0, height: 2)
        })
        
        sender.layer.borderWidth = 1
        sender.layer.borderColor = sender.tintColor.cgColor
        sender.layer.shadowOffset = CGSize(width: 0, height: 2)
        print("Selected \(String(describing: selectedCategory)) category")
    }
}
