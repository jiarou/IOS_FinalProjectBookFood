//
//  ViewController.swift
//  BookFood
//
//  Created by jiarou on 2017/5/3.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var TapReastaurant: UIButton!
    @IBOutlet weak var TapMenber: UIButton!
    @IBOutlet weak var TapFoodMap: UIButton!
    
    var userName : String = ""
    var userEmail : String = ""
    var brandName : String = ""
    var admin : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.Name.text = userName
        checkAdmin()
        print(self.brandName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemberData"{
            let memberData = segue.destination as! MemberData
            memberData.userEmail = self.userEmail
        }
        
    }
    func checkAdmin(){
        if(self.admin==true){
            // let backend = segue.destination as! BackendViewController
            // backend.brandName =self.brandName
            // let vc = self.storyboard?.instantiateViewController(withIdentifier: "Backend")
            // self.present(vc!, animated: true, completion: nil)
        }
    }
    
    
}

