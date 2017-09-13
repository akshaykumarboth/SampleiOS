//
//  ImageAsyncLoader.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/24/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import UIKit
import Photos


class ImageAsyncLoader{
    
    static func loadImageAsync(url: String, imgView: UIImageView){
        do {
            let urlObject = URL(string: url)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: urlObject!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil {
                        if urlObject?.pathExtension.range(of:"gif") != nil {
                            imgView.image = UIImage.gif(data: data!)
                        }else {
                            imgView.image = UIImage(data: data!)
                        }
                        
                    } else {
                        //imgView.image = UIImage(named: "info")
                    }
                }
            }
        }catch let error as NSError {
            print(" Error \(error)")
        }
    }
    
    static func saveVideoAsync(urlToYourVideo: String) {
        //let videoImageUrl = "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4"
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlToYourVideo),
                let urlData = NSData(contentsOf: url)
            {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(documentsPath)/tempFile.mp4";
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    }) { completed, error in
                        if completed {
                            print("Video is saved!")
                        }
                    }
                }
            }
        }
        
        
    }

    

}
