//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Andrew Ervin Gierke on 2/10/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, ShoppingItemButtonTableViewCellDelegate {
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Shopping List"
        customUI()
    }
    
    //MARK: - UI Actions 
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
    
        //Add item AlertController
        
        let alertController = UIAlertController(title: "Add item", message: "add an item to you shopping list", preferredStyle: .alert)
        
        var itemTitleTextField: UITextField?
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
    

    // MARK: - TableView datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return ItemTableViewCell()}
        
        let item = ItemController.shared.items[indexPath.row]
        cell.delegate = self
        cell.item = item
        cell.itemNamelabel.textColor = .secondaryText
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let item = ItemController.shared.items[indexPath.row]
            ItemController.shared.delete(item: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    //MARK: - Helpers
    
    func customUI() {
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .auxPurple
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.primaryText]

        let leftItem = UIBarButtonItem(title: "Shopping List",
                                       style: .plain,
                                       target: nil,
                                       action: nil)
        
        leftItem.isEnabled = false 
        self.navigationItem.leftBarButtonItem = leftItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor.primaryText
        
        
    }
    
    
    //MARK: - TableViewCellDelegate
    func itemCellButtonTapped(_ sender: ItemTableViewCell) {
        guard let item = sender.item,
            let indexPath = tableView.indexPath(for: sender) else { return }
        ItemController.shared.toggleHasPurchased(item: item)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
