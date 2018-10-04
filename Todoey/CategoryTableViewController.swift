//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Gaurav Rangnani on 18/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var categoryItemsArr: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryItemsArr?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryItemsArr?[indexPath.row].name ?? "No categories added yet"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryItemsArr?[indexPath.row]
        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { (action) in
            let categoryItem = Category()
            categoryItem.name = textfield.text!
//            self.categoryItemsArr.append(categoryItem)
            self.save(category: categoryItem)
        }
        
        alert.addTextField { (field) in
            field.placeholder = "Create New Category"
            textfield = field
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error in saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        categoryItemsArr = realm.objects(Category.self)
        tableView.reloadData()
    }
}
