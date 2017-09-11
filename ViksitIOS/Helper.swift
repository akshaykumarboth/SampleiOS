
import Foundation
import UIKit
import Photos

class Helper{
    
    static func postRequest() -> [String:String] {
        // do a post request and return post data
        return ["someData" : "someData"]
    }
    
    static func vinaykoBola(name : String) -> String {
        return "\(name) is this" as String
    }
    
    static func makeHttpCall (url : String, method: String, param: [String:String]) -> String {
        var success = "aa" 
        let semaphore = DispatchSemaphore(value: 0)

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        //
        if (request.httpMethod  == "POST" || request.httpMethod == "PUT") {
            //let postString = "{ \"name\":\"John\", \"age\":30, \"car\":null }"
            if request.httpMethod == "PUT" {
                request.addValue("application/json", forHTTPHeaderField: "Content-Type") //Optional
            }
            var postString = ""
            if param.isEmpty == false {
                for (key, value) in param {
                 postString = postString + "\(key)" + "=" + "\(value)" + "&"
                 
                }
            }
            print("herp \(postString)")
            request.httpBody = postString.data(using: .utf8)
        }
        URLSession.shared.dataTask(with:request, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                success = String(data: data, encoding: String.Encoding.utf8)!
                semaphore.signal()
            } catch let error as NSError {
                print(" error \(error)")
            }
        }).resume()
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return success
    
    }
    
    static func setHTMLString(testString: String,fontsize: String ) -> NSAttributedString{
        let str = ThemeUtil.wrapInHtml(body: testString, fontsize: fontsize)
        let attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        //textview.attributedText = attrStr
        return attrStr
    }
    
    
    static func readFromFile(fileName: String, extnsion: String) -> String{
        var result: String = ""
        //let file = "DummyData.txt" //this is the file. we will read from it
        if let path = Bundle.main.path(forResource: fileName, ofType: extnsion) {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                /*
                let myStrings = data.components(separatedBy: .newlines)
                var x : String = ""
                for string in myStrings {
                    x.append(string)
                }
                print(x)
                result = x
 */
                result = data
                
            } catch {
                print(error)
                result = ""
            }
        }
        print(result)
        return result
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                //self.imageView.image = UIImage(data: data)
            }
            
            do {
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileName = "feroz"
                let fileURL = documentsURL.appendingPathComponent("\(fileName).png")
                print("fileURL \(fileURL.absoluteString)")
                if let pngImageData = UIImagePNGRepresentation( UIImage(data: data)!) {
                    try pngImageData.write(to: fileURL, options: .atomic)
                }
            } catch let myError {
                print("caught: \(myError)")
            }
        }
    }

    //to download video in the gallery
    func downloadVideoLinkAndCreateAsset(_ videoLink: String) {
        
        // use guard to make sure you have a valid url
        guard let videoURL = URL(string: videoLink) else { return }
        
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // check if the file already exist at the destination folder if you don't want to download it twice
        if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
            
            // set up your download task
            URLSession.shared.downloadTask(with: videoURL) { (location, response, error) -> Void in
                
                // use guard to unwrap your optional url
                guard let location = location else { return }
                
                // create a deatination url with the server response suggested file name
                let destinationURL = documentsDirectoryURL.appendingPathComponent(response?.suggestedFilename ?? videoURL.lastPathComponent)
                
                do {
                    
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    
                    PHPhotoLibrary.requestAuthorization({ (authorizationStatus: PHAuthorizationStatus) -> Void in
                        
                        // check if user authorized access photos for your app
                        if authorizationStatus == .authorized {
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: destinationURL)}) { completed, error in
                                    if completed {
                                        print("Video asset created")
                                    } else {
                                        print(error)
                                    }
                            }
                        }
                    })
                    
                } catch let error as NSError { print(error.localizedDescription)}
                
                }.resume()
            
        } else {
            print("File already exists at destination url")
        }
        
    }

    
}
