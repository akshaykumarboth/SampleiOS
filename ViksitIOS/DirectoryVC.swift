//
//  DirectoryVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/27/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class DirectoryVC: UIViewController {
    
    
    @IBAction func createDirectoryPressed(_ sender: UIButton) {
        
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(mainPath)
        
        let documentDirectoryPath = mainPath + "/Create Folder"
        
        var objcBool:  ObjCBool = true
        
        let isExist = FileManager.default.fileExists(atPath: documentDirectoryPath, isDirectory: &objcBool)
        
        if !isExist {
            do {
                try FileManager.default.createDirectory(atPath: documentDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error ")
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createFolderInDocuments(folderName: String) {
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(mainPath)
        
        let documentDirectoryPath = mainPath + "/\(folderName)"
        var objcBool:  ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: documentDirectoryPath, isDirectory: &objcBool)
        
        if !isExist {
            do {
                try FileManager.default.createDirectory(atPath: documentDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error ")
            }
        }

    }

}
