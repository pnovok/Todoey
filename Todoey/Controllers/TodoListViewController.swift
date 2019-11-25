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
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        print(dataFilePath)
        
        /* let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy demogorgon"
        itemArray.append(newItem3)
        */
         
        loadItems()
        
        
        // Do any additional setup after loading the view.
      
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
        
        saveItems()
        
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
            
            self.saveItems()
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation method
    func saveItems(){
        let encoder = PropertyListEncoder()
                   
                   do{
                       let data = try encoder.encode(itemArray)
                       try data.write(to: dataFilePath!)
                   } catch{
                       print("Error encoding item array, \(error)")
                   }
                   
                   
                   self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array \(error)")
            }
        }
    }
}


