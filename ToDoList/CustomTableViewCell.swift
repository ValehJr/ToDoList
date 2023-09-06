//
//  CustomTableViewCell.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 06.09.23.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(at indexPath: IndexPath)
}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var indexPath:IndexPath?
    
    weak var delegate: CustomTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskLabel.font = UIFont(name: "Poppins-Medium", size: 13)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        delegate?.didTapDeleteButton(at: indexPath!)
    }
}
