//
//  SearchCell.swift
//  TrainSchedule
//
//  Created by Hawk on 22/02/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit

protocol ChooseExtendedCell {
    static var extendedHeight : CGFloat { get }
    static var defaultHeight : CGFloat { get }
}

class DatePickerCell: UITableViewCell, ChooseExtendedCell {
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
