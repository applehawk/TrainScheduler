//
//  SectionsRowsScheduleModel.swift
//  TrainSchedule
//
//  Created by Hawk on 01/03/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit

let kTableCellHeightRegular = 44.0
let kTableHeaderIdentifier = "kTableHeaderIdentifier"

//Only static rows
/*
    Ways Direction Section (with title in header)
        Departure Place Row (static)
            Appear dynymic rows
        Arrival Place Row (static) (with title in header)
            Appear dynamic rows
    Date Picker Section
        Date Picker Row
*/

protocol Row {
    func title() -> String
    func configurationFunctionAndIdentifier(owner: ScheduleController) -> (((UITableViewCell, NSIndexPath) -> UITableViewCell), String)
    func rowHeight() -> CGFloat
}

protocol RowBehavior {
    func didSelectRow()
    
}

protocol SectionProto {
    func title() -> String?
    func caseForRow(row: Int) -> Row?
    func headerHeight() -> CGFloat
    func headerView(tableView: UITableView) -> UIView?
    
    
}

enum Section : Int, SectionProto {
    case DepartureSection = 0
    case ArrivalSection = 1
    case VariantsSection = 2
    case DatePickerSection = 3
    
    static let allValues = [DepartureSection, ArrivalSection, VariantsSection, DatePickerSection]
    
    func rowsCount() -> Int {
        switch self {
        case .DepartureSection: return 1
        case .ArrivalSection: return 1
        //case .DirectionWaySection: return DirectionWayRow.allValues.count
        case .VariantsSection: return VariantsSectionRow.allValues.count
        case .DatePickerSection: return DatePickerRow.allValues.count
        }
    }
    
    func title() -> String? {
        switch self {
        case .DepartureSection:
            return NSLocalizedString("DEPARTURE_CITY_LABEL", comment: "Title of departure city field")
        case .ArrivalSection:
            return NSLocalizedString("ARRIVAL_CITY_LABEL", comment: "Title of arrival city label")
        case .VariantsSection:
            return NSLocalizedString("CHOOSE_VARIANTS_TITLE", comment: "Title for variants section")
        case .DatePickerSection:
            return NSLocalizedString("CHOOSE_DATE_CHOOSE_TITLE", comment: "Title for date choosing section")
        }
    }
    
    func caseForRow(row: Int) -> Row? {
        switch self {
        case .DepartureSection: return DepartureRow(rawValue: row)
        case .ArrivalSection: return ArrivalRow(rawValue: row)
        case .VariantsSection: return VariantsSectionRow(rawValue: row)
        case .DatePickerSection: return DatePickerRow(rawValue: row)
        }
    }
    
    func headerHeight() -> CGFloat {
        return CGFloat(kTableCellHeightRegular)
    }
    
    func headerView(tableView: UITableView) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(TableHeaderView.cellId) as! TableHeaderView
        if let sectionName = self.title() {
            header.titleLabel.text = sectionName
            
            
        }
        return header
    }
}

enum VariantsSectionRow : Int, Row {
    case VariantsPlace = 0
    
    static let allValues = [VariantsPlace]
    
    func title() -> String {
        return NSLocalizedString("VARIANTS_SECTION_ROW", comment: "Departure place label")
        
    }
    
    func configurationFunctionAndIdentifier(owner: ScheduleController) -> (((UITableViewCell, NSIndexPath) -> UITableViewCell), String)
    {
        switch self {
        case .VariantsPlace: return (owner.configureVariantsCell, VariantsCell.cellId)
        }
    }
    func rowHeight() -> CGFloat {
        return CGFloat(kTableCellHeightRegular)
    }
}

enum DatePickerRow : Int, Row {
    case DatePickerPlace = 0
    
    static let allValues = [DatePickerPlace]
    
    func title() -> String {
        return NSLocalizedString("DATEPICKER_SECTION_ROW", comment: "Departure place label")
        
    }
    
    func configurationFunctionAndIdentifier(owner: ScheduleController) -> (((UITableViewCell, NSIndexPath) -> UITableViewCell), String)
    {
        switch self {
        case .DatePickerPlace:
            return (owner.configureDateCell, DatePickerCell.cellId)
        }
    }
    
    func rowHeight() -> CGFloat
    {
        return CGFloat(kTableCellHeightRegular)
    }
}

enum ArrivalRow : Int, Row {
    case DeparturePlace = 0
    
    static let allValues = [DeparturePlace]
    
    func title() -> String {
        return NSLocalizedString("ARRIVAL_CITY_LABEL", comment: "Arrival place label")
        
    }
    
    func configureDirectionCell(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cell
    }
    
    func configurationFunctionAndIdentifier(owner: ScheduleController) -> (((UITableViewCell, NSIndexPath) -> UITableViewCell), String)
    {
        return (configureDirectionCell, DirectionWaysCell.cellId)
    }
    func rowHeight() -> CGFloat
    {
        return CGFloat(kTableCellHeightRegular)
    }
}

enum DepartureRow : Int, Row {
    case DeparturePlace = 0
    
    static let allValues = [DeparturePlace]
    
    func title() -> String {
        return NSLocalizedString("DEPARTURE_CITY_LABEL", comment: "Departure place label")

    }
    
    func configureDirectionCell(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cell
    }
    
    func configurationFunctionAndIdentifier(owner: ScheduleController) -> (((UITableViewCell, NSIndexPath) -> UITableViewCell), String)
    {
        return (configureDirectionCell, DirectionWaysCell.cellId)
    }
    func rowHeight() -> CGFloat
    {
        return CGFloat(kTableCellHeightRegular)
    }
}
