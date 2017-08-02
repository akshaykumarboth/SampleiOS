//
//  RoleInfoVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/2/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class RoleInfoVC: UIViewController {

    var course: Courses?
    
    @IBOutlet var roleImage: UIImageView!
    @IBOutlet var roleNameLabel: UILabel!
    @IBOutlet var roleDescriptionLabel: UILabel!
    
    

    @IBAction func onClosePressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Modules", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ModulesVC") as! ModulesVC
        nextViewController.course = course
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roleImage.layer.cornerRadius = roleImage.frame.size.width / 2
        roleImage.clipsToBounds = true
        
        roleNameLabel.text = course?.name
        roleDescriptionLabel.text = course?.description
        
        //loading image from url async
        let url = URL(string: (course?.imageURL)!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.roleImage.image = UIImage(data: data!)
            }
        }
        //
        
        
    }


}
