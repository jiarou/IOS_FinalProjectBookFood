//
//  CollectionsViewController.swift
//  Finalproject0612
//
//  Created by MAC on 2017/6/12.
//  Copyright © 2017年 MAC. All rights reserved.
//

import UIKit
import Moltin

class CollectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView:UITableView?
    
    fileprivate var restaurants:NSArray?
    
    fileprivate let COLLECTION_CELL_REUSE_IDENTIFIER = "CollectionCell"
    
    fileprivate let PRODUCTS_LIST_SEGUE_IDENTIFIER = "productsListSegue"
    
    fileprivate var selectedRestaurantDict:NSDictionary?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurant"
        
        // Loading UI
        SwiftSpinner.show("Loading Restaurant")
        
        // Get Restaurant
        
        Moltin.sharedInstance().brand.listing(withParameters: ["status": NSNumber(value: 1), "limit": NSNumber(value: 20)], success: { (response) -> Void in

            SwiftSpinner.hide()
            
            self.restaurants = response?["result"] as? NSArray
            
            self.tableView?.reloadData()
            
        }) { (response, error) -> Void in
            // Display WARNING
            
            SwiftSpinner.hide()
            AlertDialog.showAlert("Error", message: "Couldn't load collections", viewController: self)
            print("Something went wrong...")
            print(error)
        }
        
        
    }
    
    
    // MARK: - TableView Data source & Delegate
    
    // 1 cell
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Determine the number of row depending on how many restaurants
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if restaurants != nil {
            return restaurants!.count
        }
        
        return 0
    }
    
    // Make cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COLLECTION_CELL_REUSE_IDENTIFIER, for: indexPath) as! CollectionTableViewCell
        
        let row = (indexPath as NSIndexPath).row
        
        let collectionDictionary = restaurants?.object(at: row) as! NSDictionary
        
        cell.setCollectionDictionary(collectionDictionary)
        
        
        
        return cell
    }
    // Determine the selectedRestaurant
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedRestaurantDict = restaurants?.object(at: (indexPath as NSIndexPath).row) as? NSDictionary
        
        performSegue(withIdentifier: PRODUCTS_LIST_SEGUE_IDENTIFIER, sender: self)
        
        
    }
    
    func tableView(_ _tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
    }
    
    // MARK: - Navigation
    
    // Pass the value to next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == PRODUCTS_LIST_SEGUE_IDENTIFIER {
            // Set up products list view!
            let newViewController = segue.destination as! ProductListTableViewController
            
            newViewController.title = selectedRestaurantDict!.value(forKey: "title") as? String
            newViewController.restaurantId = selectedRestaurantDict!.value(forKeyPath: "id") as? String
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

