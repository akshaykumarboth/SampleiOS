//
//  ImageAsyncLoader.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/24/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation
import UIKit


class ImageAsyncLoader{
    
    static func loadImageAsync(url: String, imgView: UIImageView){
        do {
            let url = URL(string: url)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil {
                        imgView.image = UIImage(data: data!)
                        
                    } else {
                        imgView.image = UIImage(named: "info")
                    }
                }
            }
        }catch let error as NSError {
            print(" Error \(error)")
        }
    }
    

}
