//
//  MainViewController.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 02.09.23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController,CustomTableViewCellDelegate {
    
    
    @IBOutlet weak var dairyLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var tableButton: UIButton!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var tasksLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var tasks = [String]()
    var ref = Database.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeLabel.font = UIFont(name: "Poppins-Medium", size: 22)
        self.welcomeLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        self.tasksLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        self.dairyLabel.font =  UIFont(name: "Poppins-Medium", size: 13)
        self.dairyLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        
        
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = .white
        mainTable.layer.cornerRadius = 10
        mainTable.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        updateText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateText()
        addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardObserver()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAdd" {
            if let addViewController = segue.destination as? AddViewController {
                addViewController.update = { [weak self] in
                    self?.updateText()
                }
            }
        }
    }
    
    @IBAction func tableButtonAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.updateText()
        }
        performSegue(withIdentifier: "goToAdd", sender: self)
    }
    
    func updateText() {
        if let uid = Auth.auth().currentUser?.uid {
            ref.child("users").child(uid).child("tasks").observe(.value, with: { snapshot in
                if snapshot.exists() {
                    if let tasksDict = snapshot.value as? [String: String] {
                        self.tasks = Array(tasksDict.values)
                        self.mainTable.reloadData()
                    }
                }
            })
        }
    }
    func deleteTask(at index: Int) {
        if let uid = Auth.auth().currentUser?.uid {
            let taskToRemove = tasks[index]
            
            ref.child("users").child(uid).child("tasks").observeSingleEvent(of: .value, with: { snapshot in
                if snapshot.exists() {
                    if var tasksDict = snapshot.value as? [String: String] {
                        // Find the task by its name and remove it from Firebase
                        for (taskKey, taskValue) in tasksDict {
                            if taskValue == taskToRemove {
                                tasksDict[taskKey] = nil
                                self.ref.child("users").child(uid).child("tasks").setValue(tasksDict) { (error, ref) in
                                    if let err = error {
                                        print("Error deleting task from Firebase: \(err.localizedDescription)")
                                    } else {
                                        print("Task deleted from Firebase successfully")
                                    }
                                }
                                break
                            }
                        }
                        self.tasks.remove(at: index)
                        self.mainTable.reloadData()
                    }
                }
            })
        }
    }
    
    
    
    func didTapDeleteButton(at indexPath: IndexPath) {
        print("Delete button tapped at indexPath: \(indexPath)")
        deleteTask(at: indexPath.row)
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.taskLabel.text = tasks[indexPath.row]
        
        cell.backgroundColor = .white
        cell.taskLabel.textColor = .black
        
        cell.delegate = self
        
        cell.indexPath = indexPath
        
        return cell
    }
}
