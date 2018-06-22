//
//  PersonTableViewController.swift
//  PairRandomizer
//
//  Created by Huzaifa Gadiwala on 22/6/18.
//  Copyright © 2018 Huzaifa Gadiwala. All rights reserved.
//

import UIKit
import GameplayKit

class PersonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if PersonController.shared.people.count % 2 == 0 {
            return PersonController.shared.people.count / 2
        } else {
            return (PersonController.shared.people.count / 2) + 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (PersonController.shared.people.count % 2) == 0 {
            return 2
        }
        else {
            if section == (tableView.numberOfSections - 1) {
                return 1
            } else {
                return 2
            }
        }
    }
    
    func alteredIndexPath(indexPath: IndexPath) -> Int {
        return (indexPath.section * 2) + (indexPath.row)
     }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
    let person = PersonController.shared.people[alteredIndexPath(indexPath: indexPath)]
        cell.textLabel?.text = person.name

        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PersonController.shared.people[alteredIndexPath(indexPath: indexPath)]
            PersonController.shared.remove(person: personToDelete)
            // Delete the row from the data source
            self.tableView.reloadData()
        }
    }

    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentPersonController()
    }
    

    @IBAction func randomButtonTapped(_ sender: Any) {
        PersonController.shared.randomizePeople()
        self.tableView.reloadData()
    }
}

// MARK: Create and Present AlertController
// Extension for creating alert controller
extension PersonTableViewController {
    
    func presentPersonController() {
        // 0.5 - Create a optional textfield variable
        var personTextField: UITextField?
        
        // 1 - Initialize the actual alert controller
        let alertController = UIAlertController(title: "Add Person", message: "Give me the name", preferredStyle: .alert)
        
        // 2 - Add textField to alertController
        alertController.addTextField { (textField) in
            // 2.5 - Set textField we got back from alert
            personTextField = textField
        }
        
        // 3 - Add Actions
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            guard let person = personTextField?.text else { return }
            PersonController.shared.addPerson(name: person)
                       self.tableView.reloadData()
        }
        
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // 4 - Add actions to alert controller
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        // 5 - Present Alert Controller
        present(alertController, animated: true)
    }
    
}

