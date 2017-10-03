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
    //let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    /*
    //to create folder in Documents directory
    func createFolderInDocuments(folderName: String) {
        //let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
        
        let documentDirectoryPath = documentsPath + "/\(folderName)"
        var objcBool:  ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: documentDirectoryPath, isDirectory: &objcBool)
        
        if !isExist {
            do {
                try FileManager.default.createDirectory(atPath: documentDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error ")
            }
        }
        
    }*/
    
    //to create folder in Documents directory
    static func createFolderInDocuments(folderName: String, extraPath: String) {
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
    //
    /*
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
    }*/
    
    
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
    
    func x() {
        DispatchQueue.global(qos: .userInteractive).async {
            //background thread
            DispatchQueue.main.async {
                // main ui thread
            }
        }

        
        
    }

    
}
