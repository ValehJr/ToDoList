//
//  PaddedTextField.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 03.09.23.
//

import Foundation
import UIKit

class PaddedTextField: UITextField {
    let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right:10)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
    }
}
