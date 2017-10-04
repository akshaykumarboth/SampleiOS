//
//  SplashVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 10/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import Photos

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue: DispatchQueue = DispatchQueue(label: "com.viksitIOS.queue", attributes: .concurrent)
        let group:DispatchGroup = DispatchGroup()
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            
            for task in (ComplexObject(JSONString: complexCache).tasks)! {
                if let imageURL = task.imageURL {
                    queue.async (group: group) {
                        print("doing stuff")
                        self.saveFileAsync(urlString: imageURL, extraPath: "/Viksit/Viksit_TASKS/", taskID: "\(task.id!)")
                    }
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                print("done doing stuff")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Tab", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                self.present(nextViewController, animated:true, completion:nil)
            }
        }
        
        
    }
    

    func s() {
        //let queue:DispatchQueue  = DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosDefault)
        let queue: DispatchQueue = DispatchQueue(label: "com.viksitIOS.queue", attributes: .concurrent)
        let group:DispatchGroup    = DispatchGroup()
        
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
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //saving file asynchronously in document directory
    func saveFileAsync(urlString: String, extraPath: String, taskID: String) {
        //let videoImageUrl = "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4"
        MediaUtil.createFolderInDocuments(folderName: taskID, extraPath: extraPath)
        
        let finalFileName = extraPath + taskID + "/" + urlString.components(separatedBy: "/").last!
        print(finalFileName)
        
        //DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString),
                let urlData = NSData(contentsOf: url)
            {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                //let filePath="\(documentsPath)/Viksit/\(finalFileName!)"
                let filePath = "\(documentsPath)/\(finalFileName)"
                let fileExists = FileManager().fileExists(atPath: filePath)
                
                if !fileExists {
                    //DispatchQueue.main.async {
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
                    print("\(urlString.components(separatedBy: "/").last!) already exists in \(taskID)")
                }
            }
        //}
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
