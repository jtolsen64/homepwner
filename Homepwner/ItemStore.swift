//
//  ItemStore.swift
//  Homepwner
//
//  Created by Jayden Olsen on 3/13/17.
//  Copyright © 2017 Jayden Olsen. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    //Appends a new randomly created item on the allItems array.
    @discardableResult func createItem() -> Item {
        let newItem=Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    //Removes item from allItems when user deletes a cell
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    //Handles movement of items in allItems when user moves the cells in
    //edit mode
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        //Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        //Remove item from array
        allItems.remove(at: fromIndex)
        
        //Insert item at new location
        allItems.insert(movedItem, at: toIndex)
    }
}
