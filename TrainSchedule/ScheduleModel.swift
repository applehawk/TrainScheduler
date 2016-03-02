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

protocol SectionProto {
    func title() -> String?
    func caseForRow(row: Int) -> Row?
    func headerHeight() -> CGFloat
    func headerView(tableView: UITableView) -> UIView?
    
    
}

enum Section : Int, SectionProto {
    case DirectionWaySection = 0
    case VariantsSection = 1
    case DatePickerSection = 2
    
    static let allValues = [DirectionWaySection, VariantsSection, DatePickerSection]
    
    func rowsCount() -> Int {
        switch self {
        case .DirectionWaySection: return DirectionWayRow.allValues.count
        case .VariantsSection: return VariantsSectionRow.allValues.count
        case .DatePickerSection: return DatePickerRow.allValues.count
        }
    }
    
    func title() -> String? {
        switch self {
        case .DirectionWaySection:
            return NSLocalizedString("CHOOSE_DIRECTION_WAY_TITLE", comment: "Title for choosing direction way")
        case .VariantsSection:
            return NSLocalizedString("CHOOSE_VARIANTS_TITLE", comment: "Title for variants section")
        case .DatePickerSection:
            return NSLocalizedString("CHOOSE_DATE_CHOOSE_TITLE", comment: "Title for date choosing section")
        }
    }
    
    func caseForRow(row: Int) -> Row? {
        switch self {
        case .DirectionWaySection: return DirectionWayRow(rawValue: row)
        case .VariantsSection: return VariantsSectionRow(rawValue: row)
        case .DatePickerSection: return DatePickerRow(rawValue: row)
        }
    }
    
    func headerHeight() -> CGFloat {
        return CGFloat(kTableCellHeightRegular)
    }
    
    func headerView(tableView: UITableView) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(kTableHeaderIdentifier) as! TableHeaderView
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

enum DirectionWayRow : Int, Row {
    case DeparturePlace = 0
    case ArrivalPlace = 1
    
    static let allValues = [DeparturePlace, ArrivalPlace]
    
    func title() -> String {
        switch self {
        case DeparturePlace: return NSLocalizedString("DEPARTURE_CITY_LABEL", comment: "Departure place label")
        case ArrivalPlace: return NSLocalizedString("ARRIVAL_CITY_LABEL", comment: "Arrival place label")
        }
    }
    
    func configureDirectionCell(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionCase = Section.allValues[indexPath.section]
        if  let variantsCell = cell as? DirectionWaysCell,
            let rowCase = sectionCase.caseForRow(indexPath.row) {
                variantsCell.wayLabel.text = title()
        }
        return cell
    }
    
    func configurationFunctionAndIdentifier(owner: ScheduleController) -> (((UITableViewCell, NSIndexPath) -> UITableViewCell), String)
    {
        switch self {
        case .DeparturePlace: return (configureDirectionCell, DirectionWaysCell.cellId)
        case .ArrivalPlace: return (configureDirectionCell, DirectionWaysCell.cellId)
        }
    }
    func rowHeight() -> CGFloat
    {
        return CGFloat(kTableCellHeightRegular)
    }
}
