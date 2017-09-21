//
//  CalenderVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class CalenderVC: UIViewController {
    
    var events: Array<Events> = []
    
    @IBOutlet var profileBtn: UIButton!
    @IBOutlet var coinsBtn: UIButton!
    @IBOutlet var experiencePointsLabel: UILabel!
    
    @IBOutlet var topActionBar: UIView!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func onCoinsPressed(_ sender: UIButton) {
        goto(storyBoardName: "Profile", storyBoardID: "LeaderboardVC")
    }
    
    @IBAction func onProfilePressed(_ sender: UIButton) {
        goto(storyBoardName: "Profile", storyBoardID: "ProfileTBC")
    }
    
    @IBAction func onNotificationPressed(_ sender: UIButton) {
        goto(storyBoardName: "Modules", storyBoardID: "NotificationsVC")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topActionBar.backgroundColor = UIColor.Custom.themeColor
        
        var profileImgUrl: String = ""
        var xp: Int = 0
        var coins: Int = 0
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            events = ComplexObject(JSONString: complexCache).events!
            profileImgUrl = (ComplexObject(JSONString: complexCache).studentProfile?.profileImage)!
            xp = (ComplexObject(JSONString: complexCache).studentProfile?.experiencePoints)!
            coins = (ComplexObject(JSONString: complexCache).studentProfile?.coins)!
        }
        
        //inserting image from url async
        if let url = URL(string: profileImgUrl) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil {
                        self.profileBtn.setBackgroundImage(UIImage(data: data!), for: .normal)
                    } else {
                        
                        self.profileBtn.setBackgroundImage(UIImage(named: "coins"), for: .normal)
                    }
                }
            }
        }
        
        profileBtn = makeButtonRound(button: profileBtn, borderWidth: 2.5, color: UIColor.white)
        coinsBtn.setTitle(" " + String(coins), for: .normal)
        experiencePointsLabel.text = String(xp)
        
        //adjust table cell according to its content
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }
   
    func makeButtonRound(button: UIButton, borderWidth: CGFloat, color: UIColor)-> UIButton{
        button.layer.cornerRadius = button.frame.width/2
        button.layer.masksToBounds = true
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = color.cgColor
        
        return button
    }
    
    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    /*
    func setHTMLString(testString: String,fontsize: String ) -> NSAttributedString{
        let str = ThemeUtil.wrapInHtml(body: testString, fontsize: fontsize)
        var attrStr = try! NSAttributedString(
            data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        //textview.attributedText = attrStr
        return attrStr
    }
    */
    
    func getMonth(monthIndex: String) -> String {
         //months: [Int: String] = [:]
        let months:[String:String] = [ "01":"JAN", "02":"FEB", "03":"MAR", "04":"APR", "05":"MAY", "06":"JUN", "07":"JUL", "08":"AUG", "09":"SEP", "10":"OCT", "11":"NOV", "12":"DEC" ]
        
        return months[monthIndex]!
    }
    
    func setTimeFormat(dateString: String)-> String {
        let hours = getSubstring(str: dateString, startOffest: 10, endOffset: -6)
        let trimmedhours = hours.trimmingCharacters(in: .whitespacesAndNewlines)
        print("hours - > ",trimmedhours)
        let hrs = Int(trimmedhours)
        if hrs! > 12 {
            let hourNumber = hrs! - 12
            return String(hourNumber) + getSubstring(str: dateString, startOffest: 13, endOffset: -3) + " PM"
        } else if hrs! == 00{
            return "12" + getSubstring(str: dateString, startOffest: 13, endOffset: -3) + " AM"
        } else {
            return hours + getSubstring(str: dateString, startOffest: 13, endOffset: -3) + " AM"
        }
        
    }
    
    func getSubstring (str: String, startOffest: Int, endOffset: Int)-> String {
        let start = str.index(str.startIndex, offsetBy: startOffest)
        let end = str.index(str.endIndex, offsetBy: endOffset)
        let range = start..<end
        
        return str[range]
    }
    
}

extension CalenderVC: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(events[indexPath.row].id!)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "calenderCell", for: indexPath) as! CalenderTableCell
        
        // get start date // "2017-07-31 13:43:00"
        let month = getMonth(monthIndex: getSubstring(str: events[indexPath.row].startDate!, startOffest: 5, endOffset: -12))
        let date = getSubstring(str: events[indexPath.row].startDate!, startOffest: 8, endOffset: -9)
        let starthours = setTimeFormat(dateString: events[indexPath.row].startDate!)
        cell.eventDurationLabel.text = starthours /*+ getSubstring(str: events[indexPath.row].startDate!, startOffest: 13, endOffset: -3)*/
        
        cell.eventMonthLabel.text = month
        //cell.eventName.attributedText = setHTMLString(testString: events[indexPath.row].name!,fontsize: "14" )
        cell.eventName.setHTMLFromString(htmlText: events[indexPath.row].name!)
        cell.eventDateLabel.text = date
        cell.eventMonthLabel.text = month
        
        return cell
    }

}

