//
//  HomePageViewController.swift
//  ExpenseEaseHomePage
//
//  Created by Muqing Cao on 16/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class HomePageViewController: UIViewController {

    let homePageScreen = HomePageView()
    var expenses: [Expense] = []
    var selectedDate: Date?
    
    let database = Firestore.firestore()
    let currUser = Auth.auth().currentUser
    
    
    override func loadView() {
        view = homePageScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ExpenseEase"
        
        print("currUser email: \(currUser?.email)")
        
        self.view.backgroundColor = .white
        // hide the top navigation bar to avoid a too large safe area
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        selectedDate = Date()
        
        homePageScreen.tableViewExpenses.delegate = self
        homePageScreen.tableViewExpenses.dataSource = self
        homePageScreen.tableViewExpenses.separatorStyle = .none
        
        updateView(date: Date())
        
        homePageScreen.buttonCalendar.addTarget(self, action: #selector(onButtonCalendarAddTapped), for: .touchUpInside)
        homePageScreen.buttonAdd.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
    }
    
    // update the selected date and the ui when getting back to the homw page
    func updateSelectedDate(_ date: Date) {
        selectedDate = date
        updateView(date: date)
    }
    
    // called when first opened the page & the datapicker value changed
    func updateView(date: Date) {
        // fetch data from database and attach to expenses
        let startTime = Calendar.current.startOfDay(for: date)
        let endTime = Calendar.current.date(byAdding: .day, value: 1, to: startTime)!
        
        print("startTime: \(startTime)")
        print("endTime: \(endTime)")
        
        let expensesCollection = self.database.collection("users")
            .document(self.currUser?.email ?? "")
            .collection("expenses")
        
        let selectedDateExpensesCollection = expensesCollection
            .whereField("dateTime", isGreaterThanOrEqualTo: startTime)
            .whereField("dateTime", isLessThan: endTime)
            .order(by: "dateTime", descending: false)
        
        selectedDateExpensesCollection.getDocuments{ snapshot, error in
            if let uwDocuments = snapshot?.documents {
                // decode database and change the expenses array to the current docs
                self.expenses.removeAll();
                for document in uwDocuments {
                    do {
                        let expense = try document.data(as: Expense.self)
                        self.expenses.append(expense)
                    }
                    catch {
                        print("Error in decoding document to Expense")
                    }
                }
                
                // calculate today's expense
                var totalAmount = 0.0
                for document in uwDocuments {
                    let expenseData = document.data()
                    if let amount = expenseData["amount"] as? Double {
                        totalAmount += amount
                    }
                }
                
                let amountStr = "$ " + String(format: "%.2f", totalAmount)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd"
                let selectedDateString = dateFormatter.string(from: date)
                self.homePageScreen.labelDailyExpense.text = "\(selectedDateString) Expense: \(amountStr)"
                
                // update table view
                if self.expenses.isEmpty {
                    print("Expenses are empty")
                    self.homePageScreen.tableViewExpenses.isHidden = true
                    self.homePageScreen.labelDefaultNotes.isHidden = false
                }
                else {
                    print("Expenses are not empty")
                    self.homePageScreen.tableViewExpenses.isHidden = false
                    self.homePageScreen.labelDefaultNotes.isHidden = true
                    self.homePageScreen.tableViewExpenses.reloadData()
                }
            }
        }
    }
    
    // buttonAdd action
    @objc func onButtonAddTapped() {
        // TODO: change the file name here
        let addExpensePageScreen = AddExpenseViewController()
        addExpensePageScreen.delegate = self
        self.navigationController?.pushViewController(addExpensePageScreen, animated: true)
    }

    // buttonCalendar action, includes view
    @objc func onButtonCalendarAddTapped() {
        // create and configure a UIDatePicker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.date = self.selectedDate ?? Date()
        print("selected date: \(selectedDate)")
        
        // create a UIViewController for the event
        let datePickerViewController = UIViewController()
        datePickerViewController.view.backgroundColor = .white
        
        datePickerViewController.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: datePickerViewController.view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: datePickerViewController.view.trailingAnchor, constant: -20),
            datePicker.topAnchor.constraint(equalTo: datePickerViewController.view.topAnchor, constant: 20),
            datePicker.bottomAnchor.constraint(equalTo: datePickerViewController.view.bottomAnchor, constant: -20)
        ])
        
        // add action for the datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged) // when the date changed, the event datePickerValueChanged is triggered
        
        datePickerViewController.modalPresentationStyle = .overCurrentContext
        datePickerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(datePickerViewController)
        self.view.addSubview(datePickerViewController.view)

        NSLayoutConstraint.activate([
            datePickerViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            datePickerViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            datePickerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -self.view.bounds.height / 2),
            datePickerViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        datePickerViewController.didMove(toParent: self)
        
        // add toolBar and done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([doneButton], animated: false)
        datePickerViewController.view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: datePickerViewController.view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: datePickerViewController.view.trailingAnchor),
            toolbar.topAnchor.constraint(equalTo: datePickerViewController.view.topAnchor)
        ])
    }
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        selectedDate = datePicker.date
        homePageScreen.updateLabelDefaultNotes(date: selectedDate ?? Date())
        updateView(date: selectedDate ?? Date())
    }
    
    @objc func dismissDatePicker() {
        for child in children {
            if child is UIViewController {
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
    }
    
    // show image modal
    func showFullImage(image: UIImage?) {
        let fullImageViewController = UIViewController()
        fullImageViewController.view.backgroundColor = .black
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        fullImageViewController.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: fullImageViewController.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: fullImageViewController.view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: fullImageViewController.view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: fullImageViewController.view.heightAnchor)
        ])
        
        present(fullImageViewController, animated: true, completion: nil)
    }
    
    // make sure when getting back to the page, newest data is updated
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView(date: selectedDate ?? Date())
    }
    
    // delete the expense in the database
    private func deleteExpense(_ expense: Expense, completion: @escaping (Bool) -> Void) {
        let expenseToDelete = database.collection("users")
            .document(currUser?.email ?? "")
            .collection("expenses")
            .document(expense.id ?? "")
        expenseToDelete.delete() { error in
            if let error = error {
                print("Failed to delete expense: \(error.localizedDescription)")
                completion(false)
            }
            else {
                print("The expense with id = \(expense.id) has been deleted in the database.")
                completion(true)
            }
        }
    }
}


extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "record", for: indexPath) as! TableViewExpenseCell
        
        let expense = expenses[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        // assign category name
        cell.labelCategoryName.text = expense.category
        
        // find the index of the selected category and assign category icon
        if let uwIndex = Categories.categoryTitles.firstIndex(of: expense.category) {
            let categoryIconName = Categories.categoryIconImageNames[uwIndex]
            cell.imageCategory.image = UIImage(systemName: categoryIconName)
        }
        
        // assign expense date
        cell.labelInputTime.text = dateFormatter.string(from: expense.dateTime)
        
        // assign expense cost
        cell.labelCost.text = "$\(expense.amount)"
        
        // assign expense note
        cell.onNoteTap = { [weak self] in
            if let uwNote = expense.note, !uwNote.isEmpty {
                let alert = UIAlertController(title: "Expense Note", message: uwNote, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self!.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Ooops!", message: "This expense does not have any notes.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self!.present(alert, animated: true, completion: nil)
            }
        }
        
        // assign expense receipt
        cell.onReceiptTap = { [weak self] in
            
            if let uwImageUrl = expense.imageUrl {
                let storageRef = Storage.storage().reference().child(uwImageUrl)
                storageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("Error loading image: \(error.localizedDescription)")
                    } else if let data = data {
                        self?.showFullImage(image: UIImage(data: data))
                    }
                }
            }
            
            else {
                let alert = UIAlertController(title: "Ooops!", message: "This expense does not have a receipt.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self!.present(alert, animated: true, completion: nil)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExpense = expenses[indexPath.row]
        
        let editExpensePageScreen = EditExpenseViewController(expense: selectedExpense)
        editExpensePageScreen.delegate = self
        navigationController?.pushViewController(editExpensePageScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let expenseToDelete = expenses[indexPath.row]
            let alert = UIAlertController(title: "Confirm delete", message: "Are you sure you want to delete this expense?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                
                // delete the expense in the front end
                guard let self = self else { return }
                self.deleteExpense(expenseToDelete) { success in
                    if success {
                        print("backend delete success.")
                        self.expenses.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        self.homePageScreen.tableViewExpenses.reloadData()
                        self.updateView(date: self.selectedDate ?? Date())
                        print("The expense has been deleted at the front end.")
                    }
                    else {
                        let errorAlert = UIAlertController(
                            title: "Error",
                            message: "Failed to delete the expense.",
                            preferredStyle: .alert
                        )
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                }
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}
