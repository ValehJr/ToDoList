//
//  ViewMove.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 05.09.23.
//

import Foundation
import UIKit

extension UIViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotifications(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        // Add tap gesture recognizer to your view to dismiss the keyboard when the view is tapped
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func removeKeyboardObserver(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardNotifications(notification: NSNotification) {
        var txtFieldY: CGFloat = 0.0
        let spaceBetweenTxtFieldAndKeyboard: CGFloat = 5.0
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        if let activeTextField = UIResponder.currentFirst() as? UITextField ?? UIResponder.currentFirst() as? UITextView {
            // Here we will get accurate frame of the textField which is selected if there are multiple text fields
            frame = self.view.convert(activeTextField.frame, from: activeTextField.superview)
            txtFieldY = frame.origin.y + frame.size.height
        }
        
        if let userInfo = notification.userInfo {
            // here we will get frame of the keyboard (i.e. x, y, width, height)
            let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let keyBoardFrameY = keyBoardFrame!.origin.y
            let keyBoardFrameHeight = keyBoardFrame!.size.height
            
            var viewOriginY: CGFloat = 0.0
            // Check keyboard's Y position and move the view up and down accordingly
            if keyBoardFrameY >= UIScreen.main.bounds.size.height {
                viewOriginY = 0.0
            } else {
                // If the text field's Y is greater than the keyboard's Y, move the view up
                if txtFieldY >= keyBoardFrameY {
                    viewOriginY = (txtFieldY - keyBoardFrameY) + spaceBetweenTxtFieldAndKeyboard
                    
                    // Ensure that viewOriginY does not exceed the keyboard height
                    if viewOriginY > keyBoardFrameHeight { viewOriginY = keyBoardFrameHeight }
                }
            }
            
            // Set the Y position of the view to move it
            self.view.frame.origin.y = -viewOriginY
        }
    }
    
    @objc func dismissKeyboard() {
        if let activeTextField = UIResponder.currentFirst() as? PaddedTextField ?? UIResponder.currentFirst() as? UITextView {
            activeTextField.resignFirstResponder()
        }
        // Reset the view's position
        self.view.frame.origin.y = 0
    }
}



extension UIResponder {

    static weak var responder: UIResponder?

    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }

    @objc private func trap() {
        UIResponder.responder = self
    }
}
