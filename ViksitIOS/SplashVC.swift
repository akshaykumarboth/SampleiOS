//
//  SplashVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 10/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import Photos
import Firebase

class SplashVC: UIViewController {
    
    let queue: DispatchQueue = DispatchQueue(label: "com.viksitIOS.queue", qos: .userInteractive, attributes: .concurrent)
    let group:DispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        x()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        //let queue: DispatchQueue = DispatchQueue(label: "com.viksitIOS.queue", attributes: .concurrent)
        
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            
            for task in (ComplexObject(JSONString: complexCache).tasks)!.filter({$0.status == "INCOMPLETE"}) {
                if let imageURL = task.imageURL {
                    queue.async (group: group) {
                        self.saveFileAsync(urlString: imageURL, extraPath: "/Viksit/Viksit_TASKS/", optionalFolderName: "\(task.id!)/")
                    }
                }
            }
            /*
            */
            
            group.notify(queue: DispatchQueue.main) {
                print("done doing stuff")
                self.sss()
                let storyBoard : UIStoryboard = UIStoryboard(name: "Tab", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
        
    }
    
    func sss() {
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            for item in ComplexObject(JSONString: complexCache).leaderboards! {
                if let students = item.allStudentRanks {
                    for student in students {
                        if let imageURL = student.imageURL {
                            
                            DispatchQueue.global(qos: .userInteractive).async {
                                self.saveFileAsync(urlString: imageURL, extraPath: "/Viksit/Viksit_STUDENTS/", optionalFolderName: "")
                            }
                        }
                    }
                }
            }
            
            for notification in ComplexObject(JSONString: complexCache).notifications! {
                if let imageURL = notification.imageURL {
                    DispatchQueue.global(qos: .userInteractive).async {
                        self.saveFileAsync(urlString: imageURL, extraPath: "/Viksit/Viksit_NOTIFICATION/", optionalFolderName: "")
                    }
                }
            }
            
            for course in ComplexObject(JSONString: complexCache).courses! {
                if let imageURL = course.imageURL {
                    DispatchQueue.global(qos: .userInteractive).async {
                        self.saveFileAsync(urlString: imageURL, extraPath: "/Viksit/Viksit_ROLES/", optionalFolderName: "")
                    }
                }
                
                for module in course.modules! {
                    if let moduleImageURL = module.imageURL {
                        DispatchQueue.global(qos: .userInteractive).async {
                            self.saveFileAsync(urlString: moduleImageURL, extraPath: "/Viksit/Viksit_MODULE/", optionalFolderName: "\(module.id!)/")
                        }
                    }
                }
            }
        }
    }
    
    func x() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        
        //ref.child("istar-notification-ios").child("Feroz").setValue(someDictionary)
        ref.child("istar-notification").child("8").observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            for (key, value) in postDict {
                print("my key -> \(key as String)")
                if key  is Dictionary<AnyHashable,Any> {
                    print("Yes, it's a Dictionary")
                    let myref = value as! NSDictionary
                    
                    for(key1, value1) in myref {
                        print("child key -> \(key1 as! String) child values -> \(value1 as Any)")
                    }
                }else{
                    print("No , it's not a Dictionary")
                }
            }
            print("dddd \(postDict)")
            
        })
    }
    /*
    func s() {
        //let queue:DispatchQueue  = DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosDefault)
        let queue: DispatchQueue = DispatchQueue(label: "com.viksitIOS.queue", attributes: .concurrent)
        let group:DispatchGroup = DispatchGroup()
        
        print("start")
        
        queue.async (group: group) {
            print("doing stuff")
        }
        
        queue.async (group: group) {
            print("doing more stuff")
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("done doing stuff")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Tab", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            self.present(nextViewController, animated:true, completion:nil)
        }
        
    }*/

    //saving file asynchronously in document directory
    func saveFileAsync(urlString: String, extraPath: String, optionalFolderName: String) {
        //let videoImageUrl = "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4"
        MediaUtil.createFolderInDocuments(folderName: optionalFolderName, extraPath: extraPath)
        let finalFileName = extraPath + optionalFolderName + urlString.components(separatedBy: "/").last!
        
        //DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString),
                let urlData = NSData(contentsOf: url)
            {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                
                //let filePath="\(documentsPath)/Viksit/\(finalFileName!)"
                let filePath = "\(documentsPath)/\(finalFileName)"
                let fileExists = FileManager().fileExists(atPath: filePath)
                print(filePath)
                
                if !fileExists {
                    
                    //queue.async (group: group) {
                    //DispatchQueue.global(qos: .userInteractive).async {
                        print("doing stuff")
                        urlData.write(toFile: filePath, atomically: true)
                        PHPhotoLibrary.shared().performChanges({
                            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                        })
                        { completed, error in
                            if completed {
                                print("File is saved!")
                            }
                        }
                    //}
                } else {
                    if optionalFolderName != "" {
                        print("\(urlString.components(separatedBy: "/").last!) already exists in \(optionalFolderName)")
                    } else {
                        print("\(urlString.components(separatedBy: "/").last!) already exists")
                    }
                    
                }
            }
        //}
    }
    

}
