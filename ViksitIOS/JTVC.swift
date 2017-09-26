//
//  JTVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/25/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import JTAppleCalendar

class JTVC: UIViewController {
    
    @IBOutlet var prevBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var calendarView: JTAppleCalendarView!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    let formatter = DateFormatter()
    var startDate: Date?
    var endDate: Date?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //default set to todays date
        calendarView.scrollToDate(Date(), animateScroll: false)
        calendarView.selectDates([Date()])
        
        setUpCalendar()
        
        //calendarView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showNext(_ sender: UIButton) {
        //calendarView.scrollToDate(formatter.date(from: "2017 01 01")!, animateScroll: false)
        //calendarView.scroll
        calendarView.scrollToSegment(.next)
    }
    
    @IBAction func showPrev(_ sender: UIButton) {
        calendarView.scrollToSegment(.previous)
    }
    
    func setUpCalendar() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //setup label
        calendarView.visibleDates { visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalenderCell else { return }
        
        let today = Date()
        
        if today == cellState.date {
            validCell.dataLabel.textColor = UIColor.blue
        }
        
        if cellState.isSelected {
            validCell.dataLabel.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dataLabel.textColor = UIColor.black
            } else {
                validCell.dataLabel.textColor = UIColor.lightGray
            }
            
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalenderCell else { return }
        
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }
    

}

extension JTVC: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        startDate = formatter.date(from: "2017 01 01")!
        endDate = formatter.date(from: "2019 12 31")!

        
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    
}
extension JTVC: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! CalenderCell
        cell.dataLabel.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        print(date)
        //startDate = date
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
        
    }
}
