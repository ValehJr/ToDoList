//
//  LoginViewController.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 02.09.23.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordButton: UIButton!
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
        self.welcomeLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        self.registerLabel.font = UIFont(name: "Poppins-Regular", size: 15)
        self.registerLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        let placeholderColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.74)
        emailField.attributedPlaceholder = NSAttributedString(string: "Enter your Email Address", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Create a Password", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        
        self.registerButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.loginButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.forgotPasswordButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        
        self.passwordButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        
        passwordField.isSecureTextEntry = true
        
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardObserver()
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        if let email = emailField.text {
            Auth.auth().sendPasswordReset(withEmail: email){ [self] (error) in
                if let err = error {
                    let allert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                    allert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(allert,animated: true)
                } else {
                    let allert = UIAlertController(title: "Success", message: "Reset email was sent, check your inbox!", preferredStyle: .alert)
                    allert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(allert,animated: true)
                }
            }
        }
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [self] (result,error) in
                if let err = error {
                    let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                } else {
                    performSegue(withIdentifier: "goToMain", sender: self)
                }
            }
        }
    }
    @IBAction func registerButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    @IBAction func passwordButtonAction(_ sender: Any) {
        if passwordField.isSecureTextEntry{
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
    }
    
}
