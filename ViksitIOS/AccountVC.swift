//
//  AccountVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/3/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {
    
    var studentProfile: StudentProfile? = nil
    
    struct Objects {
        var sectionName: String!
        var hasmap: [String : String]
        var sectionObjects: [String]!
    }
    
    var objectsArray = [Objects]()
    @IBOutlet var profileImage: CircularImage!
    @IBOutlet var topActionBar: UIView!
    
    @IBAction func uploadPhotoPressed(_ sender: CircularButton) {
        let actionSheet = UIAlertController(title: "Change Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: {
            action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        goto(storyBoardName: "Tab", storyBoardID: "TabBarController")
    }
    
    
    @IBAction func onLogoutPressed(_ sender: UIButton) {
        goto(storyBoardName: "Tab", storyBoardID: "TabBarController")
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topActionBar.backgroundColor = UIColor.Custom.themeColor

        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            studentProfile = ComplexObject(JSONString: complexCache).studentProfile!
        }
        var mNo: String = ""
        if let y = studentProfile?.mobile {
            mNo = "\(y)"
        }
        
        objectsArray = [
            Objects(sectionName: "Personal Details",
                    hasmap: ["Name":(studentProfile?.firstName)!, "Date of Birth": (studentProfile?.dateOfBirth)!, "Email":(studentProfile?.email)!, "Mobile number": mNo, "Password": "sumanth1"],
                    sectionObjects: ["Name", "Date of Birth", "Email", "Mobile number", "Password"]),
            
            Objects(sectionName: "Educational Qualifications",
                    hasmap: ["Institution of Current Enrollment":"akshay1", "Graduate Degree":"vinay1", "Department":"karthik1",],
                    sectionObjects: ["Institution of Current Enrollment", "Graduate Degree", "Department"])
        ]
        // Do any additional setup after loading the view.
        
        ImageAsyncLoader.loadImageAsync(url: (studentProfile?.profileImage)!, imgView: profileImage)
        
    }
    
    

}

extension AccountVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showCamera(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        
        present(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .photoLibrary
        
        present(cameraPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage  {
            profileImage.image = image
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AccountVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        
        if let textlabel = header.textLabel {
            textlabel.font = textlabel.font.withSize(12)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "accountCell") as! AccountCell!
        
        cell?.cellNameLabel.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        
        let key = objectsArray[indexPath.section].sectionObjects[indexPath.row] as String
        cell?.cellValueField.text = objectsArray[indexPath.section].hasmap[key]
        
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].sectionObjects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
}
