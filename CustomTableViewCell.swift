//
//  CustomTableViewCell.swift
//  RPReplayReplica
//
//  Created by Thabo Mokgadi on 8/25/21.
//

import UIKit


///A custom table view cell, adding a text field, comment button, and segmented control.
class CustomTableViewCell: UITableViewCell {

    
//MARK: Properties
    
    ///Text field for entering comments with regard to aspect of cooler facility's risk assessment.
    var textField: UITextField!
    
    ///Button for enabling comments with regard to aspect of cooler facility's risk assessment.
    var commentButton: UIButton!
    
    ///Segemented control for assigning evaluation (acceptable, unacceptable, N/A) for each aspect of the cooler facility's risk assessment.
    var control: UISegmentedControl!
    
    ///A container view for the text field, comment button, and segemented control. Ostensibly needed to facilitate re-sizing of the cell .
    let containerView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    ///An array to keep track of which aspects of the cooler facility risk assessment have been addressed.
     private static var rowActivations = [

        (0, false),
        (1, false),
        (2, false),
        (3, false),
        (4, false),
        (5, false)
    ]

    
//MARK: Add Cell User Interface Functions
    ///Adds the container view as a subview of the cell's content view.
    func addContainerView() {
        
        self.contentView.addSubview(containerView)
    }

    ///Adds the comment button to the cell.
    func addCommentButton() {
        
        self.commentButton = UIButton()
        self.commentButton.setImage(UIImage(systemName: "plus.bubble"), for: .normal)
        self.commentButton.tintColor = .systemRed
        
        self.commentButton.addTarget(self, action: #selector(commentButtonPressed(_:)), for: .touchDown)
        
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(commentButton)
    }
    
    ///Adds the segmented control to the cell.
    func addSegementedControl() {
        
        self.control = UISegmentedControl(items: [
        
            "Acceptable", "Unacceptable", "N/A"
        ])
        
        control.addTarget(self, action: #selector(controlSegmentDidChange(_:)), for: .valueChanged)
        control.addTarget(self, action: #selector(controlSegmentEnabled(_:)), for: .valueChanged)
        
        control.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(control)
    }
    
    ///Adds the text field to the cell.
    func addTextField() {
        
        self.textField = UITextField(frame: .zero)
        self.textField.borderStyle = .roundedRect
                
        
        self.textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
       
        containerView.addSubview(textField)
    }
    
}



//MARK: Actions and Supporting Functions
extension CustomTableViewCell {

    ///Changes the image for the comment button and hides or reveals the text field.
    @objc private func commentButtonPressed(_ sender: UIButton) {
        
        let currentImage = sender.currentImage
        let plusBubble = UIImage(systemName: "plus.bubble")
        let xmark = UIImage(systemName: "xmark")
        
        switch currentImage {

        case plusBubble:
            sender.setImage(xmark, for: .normal)
            self.revealTextField()
            
        case xmark:
            sender.setImage(plusBubble, for: .normal)
            self.hideTextField()

        default:
            print("This should not run. The image should be either plus.bubble, or xmark. Check to make sure that the system name hasn't changed.")
        }        
    }
    
    ///Highlights the selected segment of the segmented control.
    @objc private func controlSegmentDidChange(_ sender: UISegmentedControl) {
        
        let currentIndex = sender.selectedSegmentIndex
        
        switch currentIndex {
        
        case 0:
            sender.selectedSegmentTintColor = .systemGreen
        
        case 1:
            sender.selectedSegmentTintColor = .systemRed
        
        case 2:
            sender.selectedSegmentTintColor = .systemGray
        
        default:
            print("Please implement additional control segement colors.")
            sender.selectedSegmentTintColor = .systemPink
        }
    }
    
    ///Determines whether or not all of the control segments have responses. When the condition is met, highlights the top row of the table view.
    @objc private func controlSegmentEnabled(_ sender: UISegmentedControl) {
                
        guard let cell = sender.superview?.superview?.superview as? CustomTableViewCell else { return }
        guard let view = cell.superview as? UITableView else { return }
        
        let row = view.indexPath(for: cell)!.row
                
        CustomTableViewCell.rowActivations[row] = (row, true) // Whatever row just sent this message is active
                
        var allItemsCompleted = false
        
        for item in CustomTableViewCell.rowActivations {
            
            if item == (0, false) {
                continue
            }
            
            if item.1 == false {
                break
            } //If an item that is not activated is hit, not all the items are activated
            
            if item == (5, true) {
                allItemsCompleted = true
            }//If the last item is activated, and a non-activated item hasn't previously been hit, all items are activated
        }
        
        if allItemsCompleted {

            view.cellForRow(at: [0,0])?.backgroundColor = .systemGreen
        }
    }
    
    ///Reveals the text view.
    private func revealTextField() {
        
        self.textField.isHidden = false
    }
    
    ///Hides the text view.
    private func hideTextField() {
        
        self.textField.isHidden = true
    }
    
}
