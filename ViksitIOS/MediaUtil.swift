//
//  MediaUtil.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/27/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import UIKit
import Photos

class MediaUtil {
    
    
    static func createFolderInDocuments(folderName: String) {
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
    
    //saving file asynchronously in document directory
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
