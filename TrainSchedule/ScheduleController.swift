//
//  ScheduleController.swift
//  TrainSchedule
//
//  Created by Hawk on 22/02/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit

extension ScheduleController {
    func configureDateCell(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionCase = Section.allValues[indexPath.section]
        if let dateCell = cell as? DatePickerCell,
            let rowCase = sectionCase.caseForRow(indexPath.row) {
                dateCell.dateLabel.text = rowCase.title()
        }
        return cell
    }
    
    func configureVariantsCell(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionCase = Section.allValues[indexPath.section]
        if let variantsCell = cell as? VariantsCell, let rowCase = sectionCase.caseForRow(indexPath.row) {
                
        }
        return cell
    }
}

class ScheduleController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionCase = Section.allValues[indexPath.section]
        
        if let rowCase = sectionCase.caseForRow(indexPath.row) {
            //If we have row for this case
            let (configFunction, identifier) = rowCase.configurationFunctionAndIdentifier(self)
            return configureCellForIdentifier(tableView, cellIdentifier: identifier, indexPath: indexPath, configurationFunction: configFunction)
        }
        
        return UITableViewCell(style: .Default, reuseIdentifier: nil)
    }
    
    func configureCellForIdentifier(tableView: UITableView, cellIdentifier: String, indexPath: NSIndexPath, configurationFunction: (UITableViewCell, NSIndexPath) -> UITableViewCell) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        return configurationFunction(cell, indexPath)
    }
    /*
    func assignValueForRowAtIndexPath(someIndexPath: NSIndexPath?, value: Any?) {
        if let indexPath = someIndexPath,
            let sectionCase = Section(rawValue: indexPath.section),
            let rowCase = sectionCase.caseForRow(indexPath.row) {
                rowCase.assignValue(self, value: value)
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Section.allValues.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionCase = Section.allValues[section] //determine type of section
        
        return sectionCase.rowsCount()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let sectionCase = Section.allValues[indexPath.section]
        if let row = sectionCase.caseForRow(indexPath.row) {
            return row.rowHeight()
        }
        return 0.0 as CGFloat
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let sectionCase = Section.allValues[section]
        if sectionCase.title() != nil {
            return sectionCase.title()
        }
        return nil
    }
    
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(headerView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionCase = Section.allValues[section]
        if sectionCase.title() != nil {
            return sectionCase.headerHeight()
        }
        return kTableCellHeightRegular as! CGFloat
    }
    

        /*
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch Sections(rawValue: indexPath.section)! {
        case .FromToSection:
            return 90
        case .DatePickerSection:
            
            if indexPath == selectedIndexPath {
                return DatePickerCell.extendedHeight
            } else {
                return DatePickerCell.defaultHeight
            }
        case .VariantsSection:
            return CGFloat(VariantsCell.rowHeight)
        default: return 10
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == Sections.DatePickerSection.rawValue {
            let previousIndexPath = selectedIndexPath
            if selectedIndexPath == indexPath {
                selectedIndexPath = nil
            } else {
                selectedIndexPath = indexPath
            }
            
            var indexPaths : Array<NSIndexPath> = []
            if let previous = previousIndexPath {
                indexPaths += [previous]
            }
            if let current = selectedIndexPath {
                indexPaths += [current]
            }
            if indexPaths.count > 0 {
                tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch Sections(rawValue: indexPath.section)! {
        case .FromToSection:
            break
        case .DatePickerSection:
            (cell as! DatePickerCell).watchFrameChanges()
        default:
            assert(true)
        }
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch Sections(rawValue: indexPath.section)! {
        case .FromToSection:
            break
        case .DatePickerSection:
            (cell as! DatePickerCell).ignoreFrameChanges()
        default:
            assert(true)
        }
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellId : String = ""
        var cell : UITableViewCell?
        
        switch Sections(rawValue: indexPath.section)! {
        case .FromToSection:
            cellId = ScheduleCell.cellId
        case .DatePickerSection:
            cellId = DatePickerCell.cellId
        case .VariantsSection:
            cellId = VariantsCell.cellId
        default: break
        }
        
        cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        
        if cellId == DatePickerCell.cellId {
            (cell as! DatePickerCell).updateValues()
        }
        
        
        return cell!
        
    }*/
}