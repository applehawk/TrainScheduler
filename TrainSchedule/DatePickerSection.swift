//
//  SearchCell.swift
//  TrainSchedule
//
//  Created by Hawk on 22/02/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit

protocol ChooseExtendedCell {
    var extendedHeight : CGFloat { get }
    var defaultHeight : CGFloat { get }
}

class DatePickerCell: UITableViewCell {
    static let cellId = "datePickerCellId"
    static let headerTitle = "Выбор даты"
    static let rowsInSection = 1
    
    var isObserving = false
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    static var extendedHeight : CGFloat { get { return CGFloat(200) } }
    static var defaultHeight : CGFloat { get { return CGFloat(46) } }
    /*
    func checkHeight() {
        datePicker.hidden = (frame.size.height < DatePickerCell.extendedHeight)
    }
    
    func updateValues() {
        //datePicker.date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        let dateString = dateFormatter.stringFromDate(datePicker.date)
        dateLabel.text = String("Date: " + dateString)
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            isObserving = true;
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }*/
}

enum DatePickerRows : Int, Row {
    case DatePickerPlace = 0
    static let allValues = [DatePickerPlace]
    
    func title() -> String {
        return NSLocalizedString("DATEPICKER_SECTION_ROW", comment: "Departure place label")
        
    }
    
    func rowsCount() -> Int {
        return 1
    }
    
    func configureDateCell(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionCase = Section.allValues[indexPath.section]
        if let dateCell = cell as? DatePickerCell,
            let rowCase = sectionCase.caseForRow(indexPath.row) {
                dateCell.dateLabel.text = title()
        }
        return cell
    }
    
    func configurationFunctionAndIdentifier(owner: ScheduleController) -> (((UITableViewCell, NSIndexPath) -> UITableViewCell), String)
    {
        switch self {
        case .DatePickerPlace: return (configureDateCell, DatePickerCell.cellId)
        }
    }
    func rowHeight() -> CGFloat
    {
        return CGFloat(kTableCellHeightRegular)
    }
    func currentValue(owner: ScheduleController) -> Any?
    {
        return nil
    }
    func assignValue(owner: ScheduleController, value: Any?)
    {
        
    }
}
