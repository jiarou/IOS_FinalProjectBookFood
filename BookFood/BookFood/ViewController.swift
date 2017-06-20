//
//  ViewController.swift
//  BookFood
//
//  Created by jiarou on 2017/5/3.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseDatabase


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var TapReastaurant: UIButton!
    @IBOutlet weak var TapMenber: UIButton!
    @IBOutlet weak var TapFoodMap: UIButton!
    @IBOutlet weak var mytable: UITableView!
    var userName : String = ""
    var userEmail : String = ""
    var brandName : String = ""
    var admin : Int = 0
    var ref:DatabaseReference!
    var  orders = [String]()
    var  status = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.Name.text = userName
        ref = Database.database().reference().child("order")
        
        ref.observe(.childAdded, with: { (snapshot) in
            let key = snapshot.key as String
            // print(key)
      
                  self.ref.child(key).child("user").observe(.value, with: { (snapshot) in
                var all_data = snapshot.value as? [String: AnyObject]
                let firebaseEmail = all_data?["email"]
                //print(firebaseEmail)
                if  (firebaseEmail?.isEqual("test1@gmail.com"))!   {
                    self.orders.append(key)
                    print(key)
        self.ref.child(key).child("orderStatus").observe(.value, with: { (snapshot) in
        let getStatus = snapshot.value as? String
            self.status.append(getStatus!)
       print(self.status)
            OperationQueue.main.addOperation({
                self.mytable.reloadData()
            })
                    })
    }
//    if self.orders != nil {
//                    OperationQueue.main.addOperation({
//                        self.mytable.reloadData()
//                    })
//                }
  
            })

        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemberData"{
            let memberData = segue.destination as! MemberData
            memberData.userEmail = self.userEmail
        }else if  segue.identifier == "segueUserOrderID"{
            if let destination = segue.destination as? UserOrderListTableViewController{
                // let cell = sender as? OrderTableViewCell
                let indexPath = self.mytable.indexPath(for: sender as! UITableViewCell)
                let postdata = orders[(indexPath?.row)!]
                destination.orderIdName = postdata
                
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.orders.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        
        cell.showOrder?.text = self.orders[indexPath.row]
        cell.showStatus?.text = self.status[indexPath.row]
        
        return cell
    }
    
    
    
    
}

