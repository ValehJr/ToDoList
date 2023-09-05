//
//  AddViewController.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 04.09.23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var taskField: PaddedTextField!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var update: (() -> Void)?
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskField.layer.cornerRadius = 10
        taskField.clipsToBounds = true
        
        self.descriptionLabel.font = UIFont(name: "Poppins-Regular", size: 15)
        self.descriptionLabel.textColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha:1)
        
        let placeholderColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.74)
        taskField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        
        self.addButton.tintColor = UIColor(red: 85/255, green: 132/255, blue: 122/255, alpha: 1)
        
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true)
       
    }

    @IBAction func addButtonAction(_ sender: Any) {
        guard let task = taskField.text, !task.isEmpty else {
            return
        }
        
        if let uid = Auth.auth().currentUser?.uid {
            let tasksRef = ref.child("users").child(uid).child("tasks")
            let tasksKey = tasksRef.childByAutoId().key!
            tasksRef.child(tasksKey).setValue(task) { (error,_ )in
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    self.update?()
                }
            }
        }
        
        print(task)
        
        update?()
        
        performSegue(withIdentifier: "goToMain", sender: self)
    }
    
}
