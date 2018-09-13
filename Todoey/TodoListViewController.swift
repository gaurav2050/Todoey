//
//  ViewController.swift
//  Todoey
//
//  Created by Gaurav Rangnani on 13/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemsArray: [TodoItem] = []
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("TodoItem.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    //MARK: tableview data source methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemsArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isSelected ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    //MARK: tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemsArray[indexPath.row].isSelected = !itemsArray[indexPath.row].isSelected
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let item = TodoItem()
            item.title = textField.text!
            self.itemsArray.append(item)
            
            self.saveItems()
            
//            self.userDefaults.set(self.itemsArray, forKey: "TodoItemArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemsArray = try decoder.decode([TodoItem].self, from: data)
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
}

