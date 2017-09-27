//
//  Directory2VC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/27/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

let theDocumentsFolderForSavingFiles = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
let theFileName = "/theUserFile.txt"

let thePathToFile = theDocumentsFolderForSavingFiles + theFileName

class Directory2VC: UIViewController {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var ageField: UITextField!
    @IBOutlet var theLabel: UILabel!
    
    
    @IBAction func saveFilePressed(_ sender: UIButton) {
        let name = nameField.text
        let lastName = lastNameField.text
        let age = ageField.text
        
        var theStringWeWillSaveAsTxtFile = "The user's info is: \(name), \(lastName), \(age)"
        
        let theFileManager = FileManager.default
        
        if  (!theFileManager.fileExists(atPath: thePathToFile)) {
            var theWriteError: NSError?
            let theFileToBeWritten = theStringWeWillSaveAsTxtFile.write(toFile: thePathToFile, atomically: true, encoding: .utf8, error: &theWriteError)
            
            if theWriteError == nil {
                print("No problem, we could save the file and the content is \(theStringWeWillSaveAsTxtFile)")
            } else {
                print("We encountered an error and this error is \(theWriteError)")
            }
        } else {
            print("File exists")
            
        }
        nameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        ageField.resignFirstResponder()
        
    }
    
    
    @IBAction func loadFilePressed(_ sender: UIButton) {
        let theInfoFromFileSaved: String = String.init(contentsOfFile: thePathToFile, encoding: .utf8)
        
        theLabel.text = theInfoFromFileSaved
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
}
