//
//  AddressEntryTableViewController.swift
//  Finalproject0612
//
//  Created by MAC on 2017/6/12.
//  Copyright © 2017年 MAC. All rights reserved.
//

import UIKit
import Moltin

class AddressEntryTableViewController: UITableViewController, TextEntryTableViewCellDelegate {
    
    var emailAddress:String?
    var billingDictionary:Dictionary<String, String>?
    
    var contactFieldsArray = Array<Dictionary< String, String>>()
    
    
    fileprivate var useSameShippingAddress = false
    
    // Field identifier key constants
    fileprivate let contactEmailFieldIdentifier = "email"
    fileprivate let contactFirstNameFieldIdentifier = "first_name"
    fileprivate let contactLastNameFieldIdentifier = "last_name"
    
    fileprivate let PAYMENT_SEGUE = "Payment"
    
    
    //MARK: - View loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fields = [contactFirstNameFieldIdentifier, contactLastNameFieldIdentifier]
        
        // Set-up extra billing address fields...
        fields = [contactEmailFieldIdentifier, contactFirstNameFieldIdentifier, contactLastNameFieldIdentifier]
            
        billingDictionary = Dictionary<String, String>()
            
        self.title = "結帳資訊"
            
        
        
        for field in fields {
            var userPresentableName = field.replacingOccurrences(of: "_", with: " ")
            userPresentableName = userPresentableName.capitalized
            
            var fieldDict = Dictionary<String, String>()
            fieldDict["name"] = userPresentableName
            fieldDict["identifier"] = field
            
            contactFieldsArray.append(fieldDict)
            
        }
        self.tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (contactFieldsArray.count + 1)
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (((indexPath as NSIndexPath).row == contactFieldsArray.count) || ((indexPath as NSIndexPath).row == contactFieldsArray.count + 1 )) {
            // Show Continue button cell!
            let cell = tableView.dequeueReusableCell(withIdentifier: CONTINUE_BUTTON_CELL_IDENTIFIER, for: indexPath) as! ContinueButtonTableViewCell
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TEXT_ENTRY_CELL_REUSE_IDENTIFIER, for: indexPath) as! TextEntryTableViewCell
        // Configure the cell
        cell.textField?.placeholder = contactFieldsArray[(indexPath as NSIndexPath).row]["name"]!
        let identifier = contactFieldsArray[(indexPath as NSIndexPath).row]["identifier"]!
        cell.cellId = identifier
        cell.delegate = self
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        var dict = billingDictionary

        
        if let existingEntry = dict![identifier] {
            if existingEntry.characters.count > 0 {
                cell.textField?.text = existingEntry
            }
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // If the user tapped on the Continue button, continue!
        if (((indexPath as NSIndexPath).row == contactFieldsArray.count) || ((indexPath as NSIndexPath).row == contactFieldsArray.count + 1)) {
            continueButtonTapped()
            return
        }
        
    }
    
    
    
    // MARK: - Data validation
    func validateData() -> Bool {
        var sourceDict:Dictionary<String, String>
        // Check email address too...
        if emailAddress == nil {
            // no email - warn!
            AlertDialog.showAlert("Error", message: "No email address entered! Please enter a valid email and try again.", viewController: self)
                
            return false
        }
            
        sourceDict = billingDictionary!
        
        
        let requiredFields = [contactFirstNameFieldIdentifier, contactLastNameFieldIdentifier]
        
        var valid = true
        
        for field in requiredFields {
            var valuePresent = false
            var lengthValid = false
            
            if let value = sourceDict[field] {
                // success
                valuePresent = true
                let stringValue = value as String
                if stringValue.characters.count < 1 {
                    // The string's empty!
                    lengthValid = true
                }
                continue
            } else {
                valuePresent = false
            }
            
            if !valuePresent || !lengthValid {
                // Warn user!
                valid = false
                
                var userPresentableName = field.replacingOccurrences(of: "_", with: " ")
                userPresentableName = userPresentableName.capitalized
                
                AlertDialog.showAlert("Error", message: "\(userPresentableName) is not present", viewController: self)
            }
        }
        
        return valid
        
    }
    
    // MARK: - Data processing
    
    // A function that gets all of the field values and returns a billing or shipping dictionary suitable to pass to the Moltin API.
    func getAddressDict() -> Dictionary<String, String> {
        var sourceDict:Dictionary<String, String>
        sourceDict = billingDictionary!
         
        
        
        var formattedDict = Dictionary<String, String>()
        formattedDict[contactFirstNameFieldIdentifier] = sourceDict[contactFirstNameFieldIdentifier]
        formattedDict[contactLastNameFieldIdentifier] = sourceDict[contactLastNameFieldIdentifier]
        
        return formattedDict
        
    }
    
    //MARK: - Text field Cell Delegate
    func textEnteredInCell(_ cell: TextEntryTableViewCell, cellId:String, text: String) {
        let cellId = cell.cellId!
        
        if cellId == contactEmailFieldIdentifier {
            emailAddress = text
            return
        }
        
        billingDictionary?[cellId] = text
        
    }
    
    //MARK: - Continue Button
    fileprivate func continueButtonTapped() {
        
        if !validateData() {
            return
        }
        
        performSegue(withIdentifier: PAYMENT_SEGUE, sender: self)
        
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        var billingDict = Dictionary<String, String>()
        

        billingDict = getAddressDict()
        
        
        if segue.identifier ==  PAYMENT_SEGUE{
            let newViewController = segue.destination as! PaymentViewController
            newViewController.billingDictionary = billingDict
            newViewController.emailAddress = emailAddress!
        }
        
    }
    
}
