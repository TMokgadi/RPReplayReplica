//
//  TableViewController.swift
//  RPReplayReplica
//
//  Created by Thabo Mokgadi on 8/24/21.
//

import UIKit


///A view controller for the table view.
class TableViewController: UITableViewController {

//MARK: Properties
    
    ///Number of rows in the table view.
    private let numberOfRows = 6
    
    ///Text for the labels of each row of the table view.
    private let labelTexts = [
        
        "Areas of observation - please note concern(s) if any, as well as corrective action(s)",
        "Surrounding Areas / Adjacent Activities",
        "Building Grounds",
        "Building Structure",
        "Water System",
        "Other"
    ]
    
//MARK: Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfRows
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let alternatingColors = indexPath.row % 2
        
        switch alternatingColors {
        
        case 0:
            cell.backgroundColor = .lightGray
        
        case 1:
            cell.backgroundColor = .white
        
        default:
            print("This should not happen, x % 2 should always be 0 or 1. Something is wrong.")
        }
        
        let label = labelTexts[indexPath.row]
        cell.textLabel?.text = label
        
        //First cell just has a label
        if (indexPath.row == 0) {
            return cell
        }
        
        
        cell.addCommentButton()
        cell.addSegementedControl()
        cell.addTextField()
        cell.addContainerView()
        
        NSLayoutConstraint.activate([
        
            cell.containerView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            cell.containerView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            cell.containerView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            cell.containerView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            
            cell.control.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: -20),
            cell.control.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            
            cell.commentButton.rightAnchor.constraint(equalTo: cell.control.leftAnchor, constant: -20),
            cell.commentButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            
            cell.textField.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),
            cell.textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),
            cell.textField.topAnchor.constraint(equalTo: cell.control.bottomAnchor, constant: 10),
            cell.textField.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 20),
        ])
        
        return cell
    }
}
