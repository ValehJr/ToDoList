//
//  RegisterViewController.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 02.09.23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var confirmPasswordButton: UIButton!
    @IBOutlet weak var passwordButton: UIButton!
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
        
        self.welcomeLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        self.descriptionLabel.textColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha:1)
        self.loginLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        self.registerButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.loginButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.passwordButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.confirmPasswordButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        
        confirmField.isSecureTextEntry = true
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
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text, let name = nameField.text, let passwordConfirm = confirmField.text {
            if password == passwordConfirm {
                Auth.auth().createUser(withEmail: email, password: password) { [self] (result, error) in
                    if let err = error {
                        let allert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                        allert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(allert, animated: true)
                    } else {
                        if let uid = Auth.auth().currentUser?.uid {
                            print("Uid:", uid)
                            Database.database().reference().child("users").child(uid).setValue([
                                "email": email, "name": name])
                        }
                        performSegue(withIdentifier: "goToLogin", sender: self)
                    }
                }
            } else {
                let allert = UIAlertController(title: "Error", message: "Password and Confirm password must be the same!", preferredStyle: .alert)
                allert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(allert, animated: true)
                confirmField.text = ""
            }
        }
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    @IBAction func passwordButtonAction(_ sender: Any) {
        if passwordField.isSecureTextEntry{
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
    }
    @IBAction func confirmPasswordAction(_ sender: Any) {
        if confirmField.isSecureTextEntry{
            confirmField.isSecureTextEntry = false
        } else {
            confirmField.isSecureTextEntry = true
        }
    }
    
}
