//
//  ViewController.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 02.09.23.
//

import UIKit
import FirebaseAuth

class LaunchViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    var window:UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeLabel.font = UIFont(name: "Poppins-Medium", size: 20)
        self.welcomeLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        self.descripLabel.font = UIFont(name: "Poppins-Regular", size: 15)
        self.descripLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        self.startButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        
        chechkForUser()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    func chechkForUser() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let user = Auth.auth().currentUser {
            performSegue(withIdentifier: "goToMain", sender: self)
            print("User is logged in:",user)
        } else {
            print("User is not logged in")
        }
    }
    
}

