//
//  TableViewExpenseCell.swift
//  ExpenseEase
//
//  Created by Chang Lin on 11/26/24.
//

import UIKit

class TableViewSpendingExpenseCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var imageCategory: UIImageView!
    var labelCategoryName: UILabel!
    var labelCategorySpending: UILabel!
    var labelCategoryPercentage: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupImageCategory()
        setupLabelCategoryName()
        setupLabelCategorySpending()
        setupLabelCategoryPercentage()
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 5
        wrapperCellView.layer.borderColor = UIColor.black.cgColor
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.translatesAutoresizingMaskIntoConstraints  = false
        self.addSubview(wrapperCellView)
    }
    
    func setupImageCategory() {
        imageCategory = UIImageView()
        imageCategory.image = (UIImage(systemName: "tag.fill"))!.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageCategory.tintColor = .black
        imageCategory.contentMode = .scaleToFill
        imageCategory.clipsToBounds = true
        imageCategory.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageCategory)
    }
    
    func setupLabelCategoryName() {
        labelCategoryName = UILabel()
        labelCategoryName.translatesAutoresizingMaskIntoConstraints  = false
        wrapperCellView.addSubview(labelCategoryName)
    }
    
    func setupLabelCategorySpending() {
        labelCategorySpending = UILabel()
        labelCategorySpending.font = UIFont.systemFont(ofSize: 16)
        labelCategorySpending.translatesAutoresizingMaskIntoConstraints  = false
        wrapperCellView.addSubview(labelCategorySpending)
    }
    
    func setupLabelCategoryPercentage() {
        labelCategoryPercentage = UILabel()
        labelCategoryPercentage.font = UIFont.systemFont(ofSize: 26)
        labelCategoryPercentage.translatesAutoresizingMaskIntoConstraints  = false
        wrapperCellView.addSubview(labelCategoryPercentage)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            // Wrapper view constraints
                wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
                wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
                wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

                // Image category constraints
                imageCategory.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
                imageCategory.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
                imageCategory.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, multiplier: 0.7),
                imageCategory.widthAnchor.constraint(equalTo: imageCategory.heightAnchor),

                // Category name label
                labelCategoryName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
                labelCategoryName.leadingAnchor.constraint(equalTo: imageCategory.trailingAnchor, constant: 8),
                labelCategoryName.trailingAnchor.constraint(lessThanOrEqualTo: labelCategoryPercentage.leadingAnchor, constant: -8),
                labelCategoryName.heightAnchor.constraint(equalToConstant: 20),

                // Category spending label
                labelCategorySpending.topAnchor.constraint(equalTo: labelCategoryName.bottomAnchor, constant: 6),
                labelCategorySpending.leadingAnchor.constraint(equalTo: labelCategoryName.leadingAnchor),
                labelCategorySpending.trailingAnchor.constraint(lessThanOrEqualTo: labelCategoryPercentage.leadingAnchor, constant: -8), // Avoid overlap
                labelCategorySpending.heightAnchor.constraint(equalToConstant: 20),

                // Percentage label
                labelCategoryPercentage.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
                labelCategoryPercentage.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -5),
                labelCategoryPercentage.widthAnchor.constraint(equalToConstant: 70),
                labelCategoryPercentage.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor),
                wrapperCellView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)

        ])
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
