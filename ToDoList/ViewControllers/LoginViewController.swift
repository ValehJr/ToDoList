//
//  LoginViewController.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 02.09.23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var passwordField: PaddedTextField!
    @IBOutlet weak var emailField: PaddedTextField!
    
    
    @IBOutlet weak var forgotPasswordButton:
        UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordField.layer.cornerRadius = 10
        passwordField.clipsToBounds = true
        emailField.layer.cornerRadius = 10
        emailField.clipsToBounds = true

        self.welcomeLabel.font = UIFont(name: "Poppins-Medium", size: 22)
        self.registerLabel.font = UIFont(name: "Poppins-Regular", size: 15)
        
        let placeholderColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.74)
        emailField.attributedPlaceholder = NSAttributedString(string: "Enter your Email Address", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Create a Password", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        
        self.registerButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.loginButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.forgotPasswordButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        
    }
    @IBAction func registerButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
}
