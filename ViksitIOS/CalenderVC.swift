//
//  CalenderVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/26/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class CalenderVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var events: Array<Events> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            events = ComplexObject(JSONString: complexCache).events!
        }
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(events[indexPath.row].id!)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "calenderCell", for: indexPath) as! CalenderTableCell
        
        
        // get start date // "2017-07-31 13:43:00"
        let month = getMonth(monthIndex: getSubstring(str: events[indexPath.row].startDate!, startOffest: 5, endOffset: -12))
        let date = getSubstring(str: events[indexPath.row].startDate!, startOffest: 8, endOffset: -9)
        let starthours = setTimeFormat(dateString: events[indexPath.row].startDate!)
        cell.eventDurationLabel.text = starthours + getSubstring(str: events[indexPath.row].startDate!, startOffest: 14, endOffset: 0)
        
        cell.eventMonthLabel.text = month
        cell.eventNameView.isUserInteractionEnabled = false
        cell.eventNameView.loadHTMLString(events[indexPath.row].name as! String, baseURL: nil)
        cell.eventDateLabel.text = date
        cell.eventMonthLabel.text = month
        
        
        return cell
    }
    
    func getMonth(monthIndex: String) -> String {
         //months: [Int: String] = [:]
        let months:[String:String] = [
            "01":"JAN",
            "02":"FEB",
            "03":"MAR",
            "04":"APR",
            "05":"MAY",
            "06":"JUN",
            "07":"JUL",
            "08":"AUG",
            "09":"SEP",
            "10":"OCT",
            "11":"NOV",
            "12":"DEC"
        ]
        
        return months[monthIndex]!
    }
    
    func setTimeFormat(dateString: String)-> String {
        let hours = getSubstring(str: dateString, startOffest: 10, endOffset: -6)
        if Int(hours)! > 12 {
            let hourNumber = Int(hours)! - 12
            return String(hourNumber)
        } else {
            return hours
        }
        
    }
    
    func getSubstring (str: String, startOffest: Int, endOffset: Int)-> String {
        let start = str.index(str.startIndex, offsetBy: startOffest)
        let end = str.index(str.endIndex, offsetBy: endOffset)
        let range = start..<end
        
        return str[range]
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
