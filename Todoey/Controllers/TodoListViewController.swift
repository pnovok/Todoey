//
//  ViewController.swift
//  Todoey
//
//  Created by Pavel Novokshonov on 11/23/19.
//  Copyright © 2019 Pavel Novokshonov. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item] ()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy demogorgon"
        itemArray.append(newItem3)
        
         
        
        
        
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        //Ternary operator - shorter version of writing the next lines of code
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        /* if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        } */
        
        return cell
    }
    
    //MARK - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        //print (itemArray[indexPath.row])
        
        //This is a short version of writing the code
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
         /* if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        } else {
            itemArray[indexPath.row].done = false
        } */
        
        tableView.reloadData()
                
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new item

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What would happen when the user pushes the Add Item button
            print("Success")
            //print(textField.text)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


