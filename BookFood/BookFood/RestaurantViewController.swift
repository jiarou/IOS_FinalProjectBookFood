//
//  RestaurantViewController.swift
//  BookFood
//
//  Created by jiarou on 2017/6/8.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RestaurantViewController: UIViewController {
     var ref: DatabaseReference!
     var shop_number = 0
     var shop_name = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gerfirebaseShoname())
        
    }
    
    func gerfirebaseShoname() -> Array<Any>  {
        ref = Database.database().reference().child("Restuarant")
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            let jason =  snapshot.value as? [String: AnyObject]
            self.shop_number = (jason?.count)!
            for i in 1...self.shop_number {
                let firebase_shop = "shop" + String(i)
                self.ref.child(firebase_shop).observe(DataEventType.value, with: { (snapshot) in
            func GetShopNameArray() -> Array<Any>{
                        var every_shop = snapshot.value as? [String: AnyObject]
                        //print(every_shop!["name"] <#default value#>?? )
                        self.shop_name.append(every_shop!["name"] as! String)
                        print(self.shop_name)
                     return  self.shop_name
                    }
                   self.shop_name = GetShopNameArray() as! [String]
                })
                           }
        })
        return  shop_name
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1//Menuimge.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCollectionViewCell
        
        // Configure the cell
       // cell.MenuView.image = UIImage(named:Menuimge[indexPath.row])
        //cell.MoneyView.text = ItemMony[indexPath.row]
        //cell.ItemView.text = ItemName[indexPath.row]
        //cell.StorageView.text = ItemStorage[indexPath.row]
        return cell
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
