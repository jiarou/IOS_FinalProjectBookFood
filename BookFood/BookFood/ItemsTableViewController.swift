//
//  ItemsTableViewController.swift
//  BookFood
//
//  Created by jiarou on 2017/6/19.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseDatabase

class ItemsTableViewController: UITableViewController {
    var ref:DatabaseReference!
    var gatOrderId : String!
    var posts = [eventStruct]()
    struct eventStruct {
        let productName: String!
        let productNumber:String!
        let Band: String!
        let productMoney : String!
        
    }
    
    @IBAction func Reject(_ sender: Any) {
        ref = Database.database().reference().child("order")
        self.ref.child("order").child(gatOrderId).child("orderStatus").setValue("無法接單")
    }
    
    @IBAction func Done(_ sender: Any) {
    ref = Database.database().reference().child("order")
        self.ref.child(gatOrderId).child("orderStatus").setValue("Done")
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
       
        print(gatOrderId)
        //self.tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "Itemcell")
        ref = Database.database().reference().child("order")
        ref.child(gatOrderId).child("items").observe(.childAdded, with: { (snapshot) in
            let data = snapshot.value as? [String: AnyObject]
           
            if(data?["Brand"]?.isEqual("佐世保"))!{
            if let valueDictionary = snapshot.value as? [AnyHashable:String]
            {
                let productName = valueDictionary["productName"]
                let productNumber = valueDictionary["productNumber"]
                let Band = valueDictionary["Band"]
                let productMoney = valueDictionary["productMoney"]
                self.posts.insert(eventStruct(productName: productName, productNumber: productNumber, Band: Band,productMoney: productMoney), at: 0)
                print(self.posts)
 
                }
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
                // }
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Itemcell", for: indexPath) as! OrderTableViewCell
    
        
  

        cell.showProductName?.text = posts[indexPath.row].productName!
        cell.showProductMoney?.text = posts[indexPath.row].productMoney!
        cell.showProductNumber?.text = posts[indexPath.row].productNumber!
        // cell.show_items.text = test[indexPath.row]
        return cell
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
