//
//  TableViewExpenseCell.swift
//  ExpenseEaseHomePage
//
//  Created by Muqing Cao on 16/10/24.
//

import UIKit

class TableViewExpenseCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var imageCategory: UIImageView!
    var labelCategoryName: UILabel!
    var labelInputTime: UILabel!
    var labelCost: UILabel!
    var buttonNote: UIButton!
    var onNoteTap: (() -> Void)?
    var buttonReceipt: UIButton!
    var onReceiptTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupImageCategory()
        setupLabelCategoryName()
        setupLabelInputTime()
        setupLabelCost()
        setupLabelNote()
        setupButtonReceipt()
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 5
        wrapperCellView.layer.borderColor = UIColor.black.cgColor
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.translatesAutoresizingMaskIntoConstraints  = false
        contentView.addSubview(wrapperCellView)
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
    
    func setupLabelInputTime() {
        labelInputTime = UILabel()
        labelInputTime.font = UIFont.systemFont(ofSize: 10)
        labelInputTime.translatesAutoresizingMaskIntoConstraints  = false
        wrapperCellView.addSubview(labelInputTime)
    }
    
    func setupLabelCost() {
        labelCost = UILabel()
        labelCost.font = UIFont.systemFont(ofSize: 14)
        labelCost.translatesAutoresizingMaskIntoConstraints  = false
        wrapperCellView.addSubview(labelCost)
    }
    
    func setupLabelNote() {
        buttonNote = UIButton(type: .system)
        buttonNote.setImage(UIImage(systemName: "note.text"), for: .normal)
        buttonNote.tintColor = .black
        buttonNote.addTarget(self, action: #selector(noteTapped), for: .touchUpInside)
        buttonNote.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(buttonNote)
    }
    
    @objc func noteTapped() {
        onNoteTap?()
    }
    
    func setupButtonReceipt() {
        buttonReceipt = UIButton(type: .system)
        buttonReceipt.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        buttonReceipt.tintColor = .black
        buttonReceipt.addTarget(self, action: #selector(receiptTapped), for: .touchUpInside)
        buttonReceipt.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(buttonReceipt)
    }
    
    @objc func receiptTapped() {
        onReceiptTap?()
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            wrapperCellView.heightAnchor.constraint(equalToConstant: 56),
            
            imageCategory.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            imageCategory.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            imageCategory.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, multiplier: 0.8),
            imageCategory.widthAnchor.constraint(equalTo: imageCategory.heightAnchor),
            
            labelCategoryName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelCategoryName.leadingAnchor.constraint(equalTo: imageCategory.trailingAnchor, constant: 8),
            labelCategoryName.heightAnchor.constraint(equalToConstant: 20),
            
            labelInputTime.topAnchor.constraint(equalTo: labelCategoryName.bottomAnchor, constant: 4),
            labelInputTime.leadingAnchor.constraint(equalTo: labelCategoryName.leadingAnchor),
            labelInputTime.heightAnchor.constraint(equalToConstant: 20),
            
            buttonReceipt.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            buttonReceipt.heightAnchor.constraint(equalToConstant: 18),
            buttonReceipt.widthAnchor.constraint(equalToConstant: 30),
            buttonReceipt.trailingAnchor.constraint(equalTo:wrapperCellView.trailingAnchor, constant: -2),
            
            buttonNote.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            buttonNote.trailingAnchor.constraint(equalTo: buttonReceipt.leadingAnchor, constant: -2),
            buttonNote.widthAnchor.constraint(equalToConstant: 30),
            
            labelCost.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            labelCost.trailingAnchor.constraint(equalTo: buttonNote.leadingAnchor, constant: -3),
            labelCost.widthAnchor.constraint(equalToConstant: 60),
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
