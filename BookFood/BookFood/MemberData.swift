//
//  MemberData.swift
//  BookFood
//
//  Created by JohnLiu on 2017/6/13.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class MemberData: UIViewController {
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    var userEmail: String = ""
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    
    @IBAction func submit(_ sender: Any) {
        let data = ["phone": self.phone.text,
                    "address": self.address.text
                    ]
        let childUpdates = ["/users/\(self.userEmail)/": data,]
        ref.updateChildValues(childUpdates)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
        self.present(vc!, animated: true, completion: nil)
    }
    func loadData(){
        self.ref = Database.database().reference()
        self.userEmail = self.userEmail.replacingOccurrences(of: ".", with: ",")
        print(self.userEmail)
        self.ref.child("users").child(self.userEmail).observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            let value = snapshot.value as? NSDictionary
            self.email.text = self.userEmail
            self.phone.text = value?["phone"] as? String ?? ""
            self.address.text = value?["address"] as? String ?? ""
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Home"{
            let Home = segue.destination as! ViewController
            Home.userEmail = self.email.text!
            let charIndex = self.email.text!.indexDistance(of: "@")!+1
            let index = self.email.text!.index(Home.userName.startIndex, offsetBy: charIndex)
            Home.userName = self.email.text!.substring(to: index)
        }
        
    }

}
