//
//  RolesVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class RolesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var roles: Array<Courses> = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "roleCell", for: indexPath) as! RoleTableCell
        
        //cell.roleImage.image = UIImage(named: animals[indexPath.row] + ".jpg" )
        cell.roleCategory.text = roles[indexPath.row].category
        cell.roleMessage.text = roles[indexPath.row].message
        cell.roleName.text = roles[indexPath.row].name
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            roles = ComplexObject(JSONString: complexCache).courses!
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
