//
//  DirectoryVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/27/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import Photos

class DirectoryVC: UIViewController {
    
    @IBAction func createDirectoryPressed(_ sender: UIButton) {
        //viksit folder creation
        //Helper.createFolderInDocuments(folderName: "Viksit")
        //getFileFromDocuments(urlString: "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(Helper.readFromFile(fileName: "assessment", extnsion: "txt"))
        
        
        //getFileFromDocuments(urlString: "http://cdn.talentify.in:9999/users/450/77f19941-bd80-43f9-86f4-2548ec14b71f.jpg")
        //writeToFileInDocuments(text: "Hiiiii", fileName: "akshay.txt", extraPath: "Viksit/")
        //readFileFromDocuments(fileName: "akshay.txt", extraPath: "Viksit/")
        // Do any additional setup after loading the view.
        
        
        /*
        //local notification implementation
        let dateComp: NSDateComponents = NSDateComponents()
        dateComp.year = 2017
        dateComp.month = 09
        dateComp.day = 27
        dateComp.hour = 18
        dateComp.minute = 49
        dateComp.timeZone = NSTimeZone.system
        
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))!
        let date: NSDate = calender.date(from: dateComp as DateComponents) as! NSDate
        
        let notification: UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Hi, I am a notification sent by AKSHAY"
        notification.fireDate = date as Date
        
        UIApplication.shared.scheduleLocalNotification(notification)
 */
    }
    
    func createFolderInDocuments(folderName: String, extraPath: String) {
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(mainPath)
        
        let documentDirectoryPath = mainPath + extraPath + folderName
        var objcBool:  ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: documentDirectoryPath, isDirectory: &objcBool)
        
        if !isExist {
            do {
                try FileManager.default.createDirectory(atPath: documentDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error ")
            }
        } else {
            print("\(folderName) already exists")
        }
        
    }
    
    func writeToFileInDocuments(text: String, fileName: String, extraPath: String) {
        let finalPath = extraPath + fileName
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(finalPath)
            print(fileURL)
            
            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
    }
    
    func readFileFromDocuments(fileName: String, extraPath: String) {
        //let file = "file.txt" //this is the file. we will write to and read from it
        let finalPath = extraPath + fileName
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(finalPath)
            print(fileURL)
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                print(text2)
            }
            catch {/* error handling here */}
        }
    }
    
    func getFileFromDocuments(urlString: String, extraPath: String) -> URL{
        let finalFileName = extraPath + urlString.components(separatedBy: "/").last!
        print(finalFileName)
        let documentsURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileUrlInDocuments = documentsURL.appendingPathComponent("\(finalFileName)")
        //let fileUrlInDocuments = "\(documentsURL)/Viksit/\(finalFileName)"
        let fileExists = FileManager().fileExists(atPath: fileUrlInDocuments.path)
        
        if !fileExists {
            saveFileAsync(urlString: urlString, extraPath: "")
        }
        
        //print(fileExists)
        return fileUrlInDocuments
    }
    
    //saving video asynchronously in document directory
    func saveFileAsync(urlString: String, extraPath: String) {
        //let videoImageUrl = "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4"
        
        let finalFileName = extraPath + urlString.components(separatedBy: "/").last!
        print(finalFileName)
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlString),
                let urlData = NSData(contentsOf: url)
            {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                //let filePath="\(documentsPath)/Viksit/\(finalFileName!)"
                let filePath="\(documentsPath)/\(finalFileName)"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    })
                    { completed, error in
                        if completed {
                            print("File is saved!")
                        }
                    }
                }
            }
        }
    }

    

}
