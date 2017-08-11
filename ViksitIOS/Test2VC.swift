//
//  Test2VC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/11/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class Test2VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    var skills: [Skills] = []
    var childSkills: [Skills] = []
    var selectedRowIndex: IndexPath = IndexPath(row: -1, section: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            skills = ComplexObject(JSONString: complexCache).skills!
        }
        
        childSkills = (skills.first?.skills)!
        // Do any additional setup after loading the view.
    }

    
    func loadImageAsync(url: String, imgView: UIImageView){
        do {
            
            let url = URL(string: url)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil {
                        imgView.image = UIImage(data: data!)
                    } else {
                        imgView.image = UIImage(named: "coins")
                        
                    }
                }
            }
            
        }catch let error as NSError {
            print(" Error \(error)")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCVCell", for: indexPath) as! TestCVCell
        cell.label.text = skills[indexPath.row].name
        loadImageAsync(url: (skills[indexPath.row].imageURL)!, imgView: cell.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height * 0.9, height: collectionView.frame.height) //use height whatever you wants.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print((skills[indexPath.row].name)!)
        
        for skill in skills{
            if skill.name == (skills[indexPath.row].name)! {
                childSkills = skill.skills!
                for child in childSkills {
                    print("childname->  \(child.name)")
                }
                
            }
        }
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var openViewHeight: Int = 50
        
        if indexPath.row == selectedRowIndex.row {
            return CGFloat(openViewHeight + 43 * (childSkills[indexPath.row].skills?.count)!)
        } else {
            return CGFloat(openViewHeight)
        }
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childSkills.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestTVCell", for: indexPath) as! TestTVCell
        
       
        cell.label.text = childSkills[indexPath.row].name
        cell.progress.progress = Float(childSkills[indexPath.row].percentage!/100)
        
        return cell
    }
    

}
