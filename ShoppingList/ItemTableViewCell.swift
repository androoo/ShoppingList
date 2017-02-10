//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Andrew Ervin Gierke on 2/10/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: class {
    func itemCellButtonTapped(_ sender: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var itemNamelabel: UILabel!
    @IBOutlet weak var hasPurchasedButton: UIButton!
    
    
    //MARK: - Properties
    
    var item: Item? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    
    //MARK: - UI Actions
    
    @IBAction func hasPurchasedButtonTapped(_ sender: UIButton) {
        
        delegate?.itemCellButtonTapped(self)
        
    }
    
    
    //MARK: - View Functions
    
    func updateViews() {
        
        guard let item = item else { return }
        itemNamelabel.text = item.name
        let checkImage = item.hasPurchased ? #imageLiteral(resourceName: "complete") : #imageLiteral(resourceName: "incomplete")
        hasPurchasedButton.setImage(checkImage, for: .normal)
    }
}
