//
//  RegisterViewController.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 02.09.23.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var confirmField: PaddedTextField!
    @IBOutlet weak var passwordField: PaddedTextField!
    @IBOutlet weak var emailField: PaddedTextField!
    @IBOutlet weak var nameField: PaddedTextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmField.layer.cornerRadius = 10
        confirmField.clipsToBounds = true
        passwordField.layer.cornerRadius = 10
        passwordField.clipsToBounds = true
        emailField.layer.cornerRadius = 10
        emailField.clipsToBounds = true
        nameField.layer.cornerRadius = 10
        nameField.clipsToBounds = true
        

        self.welcomeLabel.font = UIFont(name: "Poppins-Medium", size: 22)
        self.descriptionLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        self.loginLabel.font = UIFont(name: "Poppins-Regular", size: 15)
        
        let placeholderColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.74)
        nameField.attributedPlaceholder = NSAttributedString(string: "Enter your Full Name", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        emailField.attributedPlaceholder = NSAttributedString(string: "Enter your Email Address", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Create a Password", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        confirmField.attributedPlaceholder = NSAttributedString(string: "Confirm your Password", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        
        self.descriptionLabel.textColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha:1)
        self.registerButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.loginButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    @IBAction func registerButtonAction(_ sender: Any) {
        
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
}
