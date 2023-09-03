//
//  ViewController.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 02.09.23.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeLabel.font = UIFont(name: "Poppins-Medium", size: 20)
        self.descripLabel.font = UIFont(name: "Poppins-Regular", size: 15)
        
        self.startButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
}

