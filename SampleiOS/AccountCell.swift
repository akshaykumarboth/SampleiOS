//
//  AccountCell.swift

import UIKit

class AccountCell: UITableViewCell {
    
    @IBOutlet var cellNameLabel: UILabel!
    @IBOutlet var cellValueField: UITextField!
    @IBOutlet var editBtn: UIButton!
    
    @IBAction func onEditPressed(_ sender: UIButton) {
        if sender.isSelected {
            cellValueField.isEnabled = true
            cellValueField.becomeFirstResponder()
            sender.isSelected = false
        } else {
            cellValueField.isEnabled = false
            sender.isSelected = true
        }
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
