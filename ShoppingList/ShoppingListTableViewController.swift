//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Andrew Ervin Gierke on 2/10/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, ShoppingItemButtonTableViewCellDelegate {
    
    //MARK: - UI Actions 
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
    
        var itemTitleTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add item", message: "add an item to you shopping list", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            itemTitleTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            guard let name = itemTitleTextField?.text else { return }
            ItemController.shared.addItemNamed(name: name)
            self.tableView.reloadData()
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return ItemTableViewCell()}
        
        let item = ItemController.shared.items[indexPath.row]
        cell.delegate = self
        cell.item = item
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let item = ItemController.shared.items[indexPath.row]
            ItemController.shared.delete(item: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    //MARK: - TableViewCellDelegate
    func itemCellButtonTapped(_ sender: ItemTableViewCell) {
        guard let item = sender.item,
            let indexPath = tableView.indexPath(for: sender) else { return }
        ItemController.shared.toggleHasPurchased(item: item)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
