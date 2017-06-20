//
//  ProductListTableViewController.swift
//  Finalproject0612
//
//  Created by MAC on 2017/6/12.
//  Copyright © 2017年 MAC. All rights reserved.
//

import UIKit
import Moltin
import MapKit

class ProductListTableViewController: UITableViewController {
    
    fileprivate let CELL_REUSE_IDENTIFIER = "ProductCell"
    
    fileprivate let PRODUCT_DETAIL_VIEW_SEGUE_IDENTIFIER = "productDetailSegue"
    
    
    fileprivate var products:NSMutableArray = NSMutableArray()
    
    fileprivate var paginationOffset:Int = 0
    
    fileprivate let PAGINATION_LIMIT:Int = 3
    
    fileprivate var selectedProductDict:NSDictionary?
    
    var restaurantId:String?
    
    var positionX:String?
    var positionY:String?
    var des: String?
    var brandName: String?
    
    @IBOutlet weak var mapView: MKMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProducts(true)
        
        let initialLocation = CLLocation(latitude: Double(self.positionX!)!, longitude: Double(self.positionY!)!)
        let regionRadius: CLLocationDistance = 1000
        loadProducts(true)
        centerMapOnLocation(location: initialLocation,regionRadius: regionRadius)
        let mapData = RestaurantMapData(title: self.brandName!,
                                        locationName: self.des!,
                                        discipline: "Restaruant",
                                        coordinate: CLLocationCoordinate2D(latitude: Double(self.positionX!)!, longitude: Double(self.positionY!)!))
        
        mapView.addAnnotation(mapData)
        
    }
    
    fileprivate func loadProducts(_ showLoadingAnimation: Bool){
        assert(restaurantId != nil, "Restaurant ID is required!")
        
        // Load in the next set of products...
        
        // Show loading if neccesary?
        if showLoadingAnimation {
            SwiftSpinner.show("Loading Foods")
        }
        
        
        Moltin.sharedInstance().product.listing(withParameters: ["brand": restaurantId!, "limit": NSNumber(value: PAGINATION_LIMIT), "offset": paginationOffset], success: { (response) -> Void in
            // Let's use this response!
            SwiftSpinner.hide()
            
            
            if let newProducts:NSArray = response?["result"] as? NSArray {
                self.products.addObjects(from: newProducts as [AnyObject])
                
            }
            
            
            let responseDictionary = NSDictionary(dictionary: response!)
            
            if let newOffset:NSNumber = responseDictionary.value(forKeyPath: "pagination.offsets.next") as? NSNumber {
                self.paginationOffset = newOffset.intValue
                
            }

            self.tableView.reloadData()
            
        }) { (response, error) -> Void in
            // Something went wrong!
            SwiftSpinner.hide()
            
            AlertDialog.showAlert("Error", message: "Couldn't load products", viewController: self)
            
            print("Something went wrong...")
            print(error)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.

        
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_IDENTIFIER, for: indexPath) as! ProductsListTableViewCell
        
        let row = (indexPath as NSIndexPath).row
        
        let product:NSDictionary = products.object(at: row) as! NSDictionary
        
        cell.configureWithProduct(product)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        // Push a product detail view controller for the selected product.
        let product:NSDictionary = products.object(at: (indexPath as NSIndexPath).row) as! NSDictionary
        selectedProductDict = product
        
        performSegue(withIdentifier: PRODUCT_DETAIL_VIEW_SEGUE_IDENTIFIER, sender: self)
        
    }
    
    override func tableView(_ _tableView: UITableView,
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected object to next new view controller.
        
        if segue.identifier == PRODUCT_DETAIL_VIEW_SEGUE_IDENTIFIER {
            // Set up product detail view
            let newViewController = segue.destination as! ProductDetailViewController
            
            newViewController.title = selectedProductDict!.value(forKey: "title") as? String
            newViewController.productDict = selectedProductDict
            
        }
    }
    
    
}
