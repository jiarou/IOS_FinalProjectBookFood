//
//  member.swift
//  BookFood
//
//  Created by jiarou on 2017/5/3.
//  Copyright © 2017年 teamFour. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class member: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    
    @IBAction func submit(_ sender: Any) {
        if self.email.text == "" || self.password.text == "" {
            
            // 提示用戶是不是忘記輸入 textfield ？
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                    
                    print("You have successfully logged in")
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    // 提示用戶從 firebase 返回了一個錯誤。
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
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
extension String {
    func indexDistance(of character: Character) -> Int? {
        guard let index = characters.index(of: character) else { return nil }
        return distance(from: startIndex, to: index)
    }
}
