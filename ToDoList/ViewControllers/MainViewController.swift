//
//  MainViewController.swift
//  ToDoList
//
//  Created by Valeh Ismayilov on 02.09.23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController {

    @IBOutlet weak var tableButton: UIButton!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var tasksLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var tasks = [String]()
    var ref = Database.database().reference()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeLabel.font = UIFont(name: "Poppins-Medium", size: 22)
        
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        mainTable.delegate = self
        mainTable.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
}
