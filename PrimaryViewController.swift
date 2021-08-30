//
//  PrimaryViewController.swift
//  RPReplayReplica
//
//  Created by Thabo Mokgadi on 8/24/21.
//

import UIKit

///The primary controller for the view.
class PrimaryViewController: UIViewController {

//MARK: UI Properties
    
    ///The stack view for the window.
    private weak var stackView: UIStackView!
    
    ///The navigation bar for the window.
    private weak var navigationBar: UINavigationBar!
    
    ///Bottom toolbar in the stack view.
    private weak var bottomToolbar: UIToolbar!
    
    ///Upper toolbar in the stack view.
    private weak var upperToolbar: UIToolbar!
    
    ///Table view in the stack view.
    private weak var tableView: UITableView!
    
    ///Table view's view controller.
    private let tableViewController = TableViewController()
    
//MARK: Properties
    
    ///Title for the window.
    private let viewTitle = "Cooler Facility Risk Assessment"
    
    ///Title for the previous window.
    private let previousViewTitle = "Documents"
    
    ///Dashboard image for bottom toolbar.
    private let dashboardImage = UIImage(systemName: "square.stack.3d.up")!
    
    ///Food safety image for bottom toolbar.
    private let foodSafetyImage = UIImage(systemName: "exclamationmark.triangle")!
    
//MARK: View Initialization
    
    ///Adds the various UI elements to the stack view.
    override func loadView() {
        super.loadView()
        
        
        self.setUpStackView()
        self.addNavigationBar()
        self.addBottomToolbar()
        self.addUpperToolbar()
        self.addTableView()
    }
    
    
    ///Provides settings and constraints for the various UI elements in the stack view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //stackView settings
        stackView.backgroundColor = .white
        
        //navigationBar settings
        let navigationItem = UINavigationItem()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: previousViewTitle,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        
        navigationItem.backBarButtonItem?.tintColor = .systemRed
        
        let navigationItem2 = UINavigationItem(title: viewTitle)
        
        navigationBar.setItems([navigationItem, navigationItem2], animated: false)
        
        //bottomToolbar settings
        let dashboardItem = UIBarButtonItem(image: dashboardImage,
                                            style: .plain,
                                            target: nil,
                                            action: #selector(toDashboard(_:)))
        
        let dashboardTextItem = UIBarButtonItem(title: "Dashboard",
                                                style: .plain,
                                                target: nil,
                                                action: #selector(toDashboard(_:)))
        
        let foodSafetyItem = UIBarButtonItem(image: foodSafetyImage,
                                             style: .plain,
                                             target: nil,
                                             action: #selector(foodSafety(_:)))
        
        let foodSafetyTextItem = UIBarButtonItem(title: "Food Safety",
                                                 style: .plain,
                                                 target: nil,
                                                 action: #selector(foodSafety(_:)))
        
        let flexibleSpace = UIBarButtonItem.flexibleSpace()
        
        dashboardItem.tintColor = .systemGray2
        dashboardTextItem.tintColor = .systemGray2
        
        foodSafetyItem.tintColor = .systemRed
        foodSafetyTextItem.tintColor = .systemRed
        
        bottomToolbar.setItems([flexibleSpace, dashboardItem, dashboardTextItem,
                                flexibleSpace,
                                foodSafetyItem, foodSafetyTextItem, flexibleSpace],
                               
                               animated: false)
        
        //upperToolbar settings
        let saveChangesTextItem = UIBarButtonItem(title: "Save Changes",
                                                  style: .plain,
                                                  target: nil,
                                                  action: #selector(saveChanges(_:)))
        
        let finalSubmitTextItem = UIBarButtonItem(title: "Final Submit",
                                                  style: .plain,
                                                  target: nil,
                                                  action: #selector(finalSubmission(_:)))
        
        saveChangesTextItem.tintColor = .systemRed
        finalSubmitTextItem.tintColor = .systemRed
        
        upperToolbar.setItems([flexibleSpace, saveChangesTextItem, flexibleSpace,
                               finalSubmitTextItem, flexibleSpace],
                              animated: false)
        
        //tableView settings
        tableView.delegate = tableViewController
        tableView.dataSource = tableViewController
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
        
    

}

// MARK: View Set-up Functions
extension PrimaryViewController {
    
    ///Initializes and provides constraints for the stack view.
    private func setUpStackView() {
        
        let baseStackView = UIStackView()
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(baseStackView)
        
        NSLayoutConstraint.activate([

            baseStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            baseStackView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        
        self.stackView = baseStackView
    }
    
    ///Adds the navigation bar to the stack view and provides constraints. Must be called after setUpStackView.
    private func addNavigationBar() {
        
        //Do not want to add this to nonexistent view.
        guard let _ = stackView else {return}
        
        let baseNavigationBar = UINavigationBar(frame: .zero)
        baseNavigationBar.prefersLargeTitles = true
        baseNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addSubview(baseNavigationBar)
        
        NSLayoutConstraint.activate([
        
            baseNavigationBar.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40),
            baseNavigationBar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            baseNavigationBar.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
        
        self.navigationBar = baseNavigationBar
    }
    
    ///Adds the bottom toolbar to the stack view and provides constraints. Must be called after setUpStackView.
    private func addBottomToolbar() {
        
        //Do not want to add this to nonexistent view.
        guard let _ = stackView else {return}
        
        let bounds = self.view.window?.bounds ?? CGRect(x: 0, y: 0, width: 100, height: 100)
        let baseToolbar = UIToolbar(frame: bounds)
        baseToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addSubview(baseToolbar)
        
        NSLayoutConstraint.activate([
        
            baseToolbar.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -20),
            baseToolbar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            baseToolbar.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
        
        self.bottomToolbar = baseToolbar
    }
    
    ///Adds the upper toolbar to the stack view and provides constraints. Must be called after addBottomToolbar.
    private func addUpperToolbar() {
        
        //Do not want to add this to nonexistent view.
        guard let _ = stackView else {return}
        
        //Do not want to have constraints equal to nil
        guard let _ = bottomToolbar else {return}
        
        let bounds = self.view.window?.bounds ?? CGRect(x: 0, y: 0, width: 100, height: 100)
        let baseToolbar = UIToolbar(frame: bounds)
        baseToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addSubview(baseToolbar)
        
        NSLayoutConstraint.activate([
        
            baseToolbar.bottomAnchor.constraint(equalTo: bottomToolbar.topAnchor, constant: -2),
            baseToolbar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            baseToolbar.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
        
        self.upperToolbar = baseToolbar
    }
    
    
    ///Adds a table view to the stack view. Must be called after adding upper toolbar and navigation bar.
    private func addTableView() {
        
        guard let _ = stackView else {return}
        guard let _ = upperToolbar else {return}
        guard let _ = navigationBar else {return}
        
        let baseTableView = UITableView(frame: .zero, style: .plain)
        baseTableView.isScrollEnabled = false
        
        baseTableView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addSubview(baseTableView)
        
        NSLayoutConstraint.activate([
        
            baseTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            baseTableView.bottomAnchor.constraint(equalTo: upperToolbar.topAnchor),
            baseTableView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
        ])
        
        self.tableView = baseTableView
    }
    
}


//MARK: Button Actions

extension PrimaryViewController {
    
    ///Stub
    @objc private func returnToDocuments(_ sender: UIButton) {
        
        print("returnToDocuments")
    }
    
    ///Stub
    @objc private func finalSubmission (_ sender: UIButton) {
        
        print("finalSubmission")
    }
    
    ///Stub
    @objc private func foodSafety(_ sender: UIButton) {
        
        print("foodSafety")
    }
    
    ///Stub
    @objc private func saveChanges (_ sender: UIButton) {
        
        print("saveChanges")
    }
    
    ///Stub
    @objc private func toDashboard (_ sender: UIButton) {
        
        print("toDashboard")
    }
    
    
}
