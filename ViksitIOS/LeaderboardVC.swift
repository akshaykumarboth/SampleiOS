//
//  DummyVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 8/4/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class LeaderboardVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //var animals = ["dogff", "cat", "fox"]
    var pickerList: [String] = []
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        goto(storyBoardName: "Tab", storyBoardID: "TabBarController")
        
    }
    
    
    @IBOutlet var secondTopperImage: UIImageView!
    @IBOutlet var secondTopperRank: CircularButton!
    @IBOutlet var secondTopperName: UILabel!
    @IBOutlet var secondTopperXP: UILabel!
    
    @IBOutlet var firstTopperImage: UIImageView!
    @IBOutlet var firstTopperRank: CircularButton!
    @IBOutlet var firstTopperName: UILabel!
    @IBOutlet var firstTopperXP: UILabel!
    
    @IBOutlet var thirdTopperImage: UIImageView!
    @IBOutlet var thirdTopperRank: CircularButton!
    @IBOutlet var thirdTopperName: UILabel!
    @IBOutlet var thirdTopperXP: UILabel!
    
    var studentRankList: Array<AllStudentRanks>?
    var topperList: Array<AllStudentRanks>?
    @IBOutlet var studentsTableView: UITableView!
    var leaderboards: Array<Leaderboards>?
    @IBOutlet var rolesPicker: UIPickerView!
    @IBOutlet var pickView: UIView!
    @IBOutlet var rolesBtn: UIButton!
    
    @IBAction func onRolesPressed(_ sender: UIButton) {
        if sender.isSelected {
            hideRoles()
            sender.isSelected = false
        } else {
            showRoles()
            sender.isSelected = true
        }
    }
    
    func showRoles() {
        view.addSubview(pickView)
        
        let topConstraint = pickView.topAnchor.constraint(equalTo: rolesBtn.bottomAnchor)
        let rightConstraint = pickView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let widthConstraint = pickView.widthAnchor.constraint(equalToConstant: view.frame.width/2)
        let heightConstraint = pickView.heightAnchor.constraint(equalToConstant: CGFloat(20 * pickerList.count))
        
        NSLayoutConstraint.activate([topConstraint, rightConstraint, widthConstraint, heightConstraint])
        view.layoutIfNeeded()
    }
    
    func hideRoles(){
        pickView.removeFromSuperview()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            leaderboards = ComplexObject(JSONString: complexCache).leaderboards!
        }
        
        for item in leaderboards! {
            pickerList.append(item.name!)
            if item.name == "All Roles" {
                if let ranks = item.allStudentRanks {
                    studentRankList = Array(ranks[3..<(ranks.count)])
                    topperList = Array(ranks[0..<3])
                }
            }
        }
        rolesBtn.setTitle(pickerList[0], for: .normal)
        setToppers()
        
        pickView.translatesAutoresizingMaskIntoConstraints = false
        
  

        // Do any additional setup after loading the view.
    }
    
    
    func setToppers() {
        //first topper
        loadImageAsync(url: ((topperList?[1].imageURL))!, imgView: firstTopperImage)
        makeImageRound(image: firstTopperImage)
        
        if let firstrank =  topperList?[1].batchRank {
            firstTopperRank.setTitle("\(firstrank)", for: .normal)
        }
        firstTopperName.text = topperList?[1].name
        if let firstTopperPoints = topperList?[1].points {
            firstTopperXP.text = "\(firstTopperPoints)" + " XP"
        }
        
        //second topper
        loadImageAsync(url: (topperList?[0].imageURL)!, imgView: secondTopperImage)
        makeImageRound(image: secondTopperImage)
        if let secondrank =  topperList?[0].batchRank {
            secondTopperRank.setTitle("\(secondrank)", for: .normal)
        }
        secondTopperName.text = topperList?[0].name
        if let secondTopperPoints = topperList?[0].points {
            secondTopperXP.text = "\(secondTopperPoints)" + " XP"
        }
        
        
        //third topper
        loadImageAsync(url: (topperList?[2].imageURL)!, imgView: thirdTopperImage)
        makeImageRound(image: thirdTopperImage)
        if let thirdrank =  topperList?[2].batchRank {
            thirdTopperRank.setTitle("\(thirdrank)", for: .normal)
        }
        thirdTopperName.text = topperList?[2].name
        if let thirdTopperpoints = topperList?[2].points {
            thirdTopperXP.text = "\(thirdTopperpoints)" + " XP"
        }
        
    }
    
    func loadImageAsync(url: String, imgView: UIImageView){
        do {
            
            let url = URL(string: url)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil {
                        imgView.image = UIImage(data: data!)
                    }
                }
            }
            
        }catch let error as NSError {
            print(" Error \(error)")
        }
    }

    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        label.text = pickerList[row]
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rolesBtn.setTitle(pickerList[row], for: .normal)
        
        for item in leaderboards! {
            if item.name == pickerList[row] {
                
                if let ranks = item.allStudentRanks {
                    studentRankList = Array(ranks[3..<(ranks.count)])
                    topperList = Array(ranks[0..<3])
                }
                
            }
        }
        
        studentsTableView.reloadData()
        setToppers()
        print("data reloaded")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

   

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentRankList!.count
    }
    
    
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderBoardCell", for: indexPath) as! LeaderboardCell
        
        //cell.mText.text = animals[indexPath.row]
        //loa
        loadImageAsync(url: (studentRankList?[indexPath.row].imageURL)!, imgView: cell.studentImage)
        makeImageRound(image: cell.studentImage)
        cell.studentName.text = studentRankList?[indexPath.row].name
        cell.studentRank.text = ordinal(i: (studentRankList?[indexPath.row].batchRank)!)
        cell.studentXP.text = String(Int((studentRankList?[indexPath.row].points)!))
        
        return cell
    }
    
    func makeImageRound(image: UIImageView){
        //image.layer.cornerRadius = image.frame.height / 2
        //image.layer.masksToBounds = true
        //image.clipsToBounds = true
        image.layer.borderWidth=1.0;
        image.layer.borderColor = UIColor(red: 235/255, green: 56/255, blue: 79/255, alpha: 1.00).cgColor

        
    }
    
    func ordinal(i:Int)-> String{
        var sufixes: [String] = ["th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th"]
        switch (i % 100) {
        case 11,12,13:
            return String(i) + "th"
        default:
            return String(i) + sufixes[i % 10]
            
        }
    }

}
