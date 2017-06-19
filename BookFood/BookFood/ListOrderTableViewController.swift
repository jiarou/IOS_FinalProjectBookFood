//
//  ListOrderTableViewController.swift
//  BookFood
//
//  Created by jiarou on 2017/6/19.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseDatabase

class ListOrderTableViewController: UITableViewController {
    var ref:DatabaseReference!
    var orders = [String]()
    var userNames = [String]()
    var userPhone = [String]()
    var order: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("order")
        
        
        ref.observe(.childAdded, with: { (snapshot) in
            let key = snapshot.key as String
            self.ref.child(key).child("items").queryOrdered(byChild: "Band").queryEqual(toValue: "假面騎士").observe(.childAdded, with: { (snapshot) in
                
                print(self.orders)
                if self.orders.contains(key)  {
                    if let index = self.orders.index(of: key) {
                        self.orders.remove(at: index)
                        print(self.orders)
                    }
                }
                self.orders.append(key)
                print(key)
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            })
            self.ref.child(key).child("user").observe(.value, with: { (snapshot) in
                var all_data = snapshot.value as? [String: AnyObject]
                let firebaseUser = all_data?["username"]
                //print(firebaseUser)
                if  firebaseUser != nil {
                    self.userNames.append(firebaseUser as! String)
                    print(self.userNames)
                }
                let firebasePhone = all_data?["userphone"]
                
                if  firebasePhone != nil {
                    self.userPhone.append(firebasePhone as! String)
                }
                
                
                print(all_data)
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
                
                
            })
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
        return orders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oderListCell", for: indexPath) as! ListOrderTableViewCell
        cell.showOrders?.text = orders[indexPath.row]
        cell.showUserName?.text = userNames[indexPath.row]
        cell.showUsePhone?.text = userPhone[indexPath.row]
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueOrderID"{
            if let destination = segue.destination as? ItemsTableViewController{
                // let cell = sender as? OrderTableViewCell
                let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
                let postdata = orders[(indexPath?.row)!]
                destination.gatOrderId = postdata
                
            }
            
        }
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
