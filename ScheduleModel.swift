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

protocol Row {
    func title() -> String
    func rowsCount() -> Int
    
    func configurationFunctionAndIdentifier(owner: ScheduleController) -> (((UITableViewCell, NSIndexPath) -> UITableViewCell), String)
    func rowHeight() -> CGFloat
    func currentValue(owner: ScheduleController) -> Any?
    func assignValue(owner: ScheduleController, value: Any?)
}

protocol SectionProto {
    func title() -> String?
    func caseForRow(row: Int) -> Row?
    func headerHeight() -> CGFloat
    func headerView() -> UIView?
}

enum Section : Int {
    case DirectionWaySection = 0
    case VariantsSection = 1
    case DatePickerSection = 2
    
    static let allValues = [DirectionWaySection, VariantsSection, DatePickerSection]
    
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
    
    func toRow() -> Row? {
        return self.caseForRow(self.rawValue)
    }
    
    func caseForRow(row: Int) -> Row? {
        switch self {
        case .DirectionWaySection: return DirectionWayRows(rawValue: row)
        case .VariantsSection: return VariantsSectionRows(rawValue: row)
        case .DatePickerSection: return DatePickerRows(rawValue: row)
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
