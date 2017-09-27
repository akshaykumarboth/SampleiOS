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
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Helper.readFromFile(fileName: "assessment", extnsion: "txt"))
        
        getFileFromDocuments(urlString: "http://txt2html.sourceforge.net/sample.txt")

        // Do any additional setup after loading the view.
    }
    
    func getFileFromDocuments(urlString: String) -> URL{
        let finalFileName = urlString.components(separatedBy: "/").last
        print(finalFileName!)
        let documentsURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileUrlInDocuments = documentsURL.appendingPathComponent(finalFileName!)
        let fileExists = FileManager().fileExists(atPath: fileUrlInDocuments.path)
        
        if !fileExists {
            saveFileAsync(urlString: urlString)
        }
        
        //print(fileExists)
        return fileUrlInDocuments
    }
    
    //saving video asynchronously in document directory
    func saveFileAsync(urlString: String) {
        //let videoImageUrl = "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4"
        
        let finalFileName = urlString.components(separatedBy: "/").last
        print(finalFileName!)
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlString),
                let urlData = NSData(contentsOf: url)
            {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let filePath="\(documentsPath)/\(finalFileName!)"
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
