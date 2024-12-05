//
//  HomePageView.swift
//  ExpenseEaseHomePage
//
//  Created by Muqing Cao on 16/10/24.
//

import UIKit

class HomePageView: UIView {
    
    var buttonCalendar: UIButton!
    var buttonCalendarImage: UIImage!
    
    var labelDailyExpense: UILabel!
    
    var labelDefaultNotes: UILabel!
    
    var tableViewExpenses: UITableView!
    
    var buttonAdd: UIButton!
    var buttonAddImage: UIImage!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupButtonCalendar()
        setupLabelDailyExpense()
        
        setupLabelDefaultNotes()
        
        setupTableViewExpenses()
        
        setupButtonAdd()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtonCalendar() {
        buttonCalendar = UIButton(type: .system)
        
        buttonCalendarImage = UIImage(systemName: "calendar")
        buttonCalendar.setBackgroundImage(buttonCalendarImage, for: .normal)
        buttonCalendar.backgroundColor = .clear
        buttonCalendar.tintColor = .black
        buttonCalendar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonCalendar)
    }
    
    func setupLabelDailyExpense() {
        labelDailyExpense = UILabel()
        labelDailyExpense.backgroundColor = .white
        labelDailyExpense.layer.borderWidth = 1.5
        labelDailyExpense.layer.cornerRadius = 10
        labelDailyExpense.layer.borderColor = UIColor.black.cgColor
        labelDailyExpense.textAlignment = .center
        labelDailyExpense.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDailyExpense)
    }
    
    func setupLabelDefaultNotes() {
        labelDefaultNotes = UILabel()
        labelDefaultNotes.numberOfLines = 0
        labelDefaultNotes.lineBreakMode = .byWordWrapping
        labelDefaultNotes.textAlignment = .center
        labelDefaultNotes.text = """
        No expense for today.
        
        Click the upper left calendar burtton to switch dates.
        """
        labelDefaultNotes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDefaultNotes)
    }
    
    func updateLabelDefaultNotes(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        var formattedDate = dateFormatter.string(from: date)
        if (Calendar.current.isDate(date, inSameDayAs: Date())) {
            formattedDate = "today"
        }
        labelDefaultNotes.text = """
        No expense for \(formattedDate).
        
        Click the upper left calendar burtton to switch dates.
        """
    }
    
    func setupTableViewExpenses() {
        tableViewExpenses = UITableView()
        tableViewExpenses.register(TableViewExpenseCell.self, forCellReuseIdentifier: "record")
        tableViewExpenses.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewExpenses)
    }
    
    func setupButtonAdd() {
        buttonAdd = UIButton()
        buttonAdd.backgroundColor = .white
        buttonAdd.layer.borderWidth = 1.5
        buttonAdd.layer.cornerRadius = 10
        buttonAdd.layer.borderColor = UIColor.black.cgColor
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        
        buttonAddImage = UIImage(systemName: "square.and.pencil")
        buttonAdd.tintColor = .black
        buttonAdd.setImage(buttonAddImage, for: .normal)
        buttonAdd.setTitle("Add", for: .normal)
        buttonAdd.setTitleColor(.black, for: .normal)
            
        self.addSubview(buttonAdd)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            buttonCalendar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 2),
            buttonCalendar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            buttonCalendar.heightAnchor.constraint(equalToConstant: 48),
            buttonCalendar.widthAnchor.constraint(equalTo: buttonCalendar.heightAnchor),
            
            labelDailyExpense.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 3),
            labelDailyExpense.leadingAnchor.constraint(equalTo: buttonCalendar.trailingAnchor, constant: 32),
            labelDailyExpense.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            labelDailyExpense.heightAnchor.constraint(equalToConstant: 42),
            
            labelDefaultNotes.topAnchor.constraint(equalTo: buttonCalendar.bottomAnchor, constant: 225),
            labelDefaultNotes.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelDefaultNotes.widthAnchor.constraint(equalToConstant: 256),

            // botton view constraints
            buttonAdd.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -72),
            buttonAdd.trailingAnchor.constraint(equalTo: labelDailyExpense.trailingAnchor),
            buttonAdd.heightAnchor.constraint(equalToConstant: 56),
            buttonAdd.widthAnchor.constraint(equalToConstant: 108),
            
            tableViewExpenses.topAnchor.constraint(equalTo: buttonCalendar.bottomAnchor, constant: 48),
            tableViewExpenses.leadingAnchor.constraint(equalTo: buttonCalendar.leadingAnchor),
            tableViewExpenses.trailingAnchor.constraint(equalTo: buttonAdd.trailingAnchor),
            tableViewExpenses.bottomAnchor.constraint(equalTo: buttonAdd.topAnchor, constant: -36),
            
        ])
        
    }
}
