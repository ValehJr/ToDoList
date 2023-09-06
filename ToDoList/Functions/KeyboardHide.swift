//
//  KeyboardHide.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 03.09.23.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

}
