//
//  VariantsCell.swift
//  TrainSchedule
//
//  Created by Hawk on 29/02/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import UIKit

class VariantsCell: UITableViewCell {
    static let cellId = "variantsCellId"
    static let headerTitle = "Варианты"
    
    static var headerHeight = 5.0
    static var rowHeight = 10.0
    
    static var rowsInSection = 1
}

enum VariantsSectionRows : Int, Row {
    case VariantsPlace = 0
    
    static let allValues = [VariantsPlace]
    func title() -> String {
        return NSLocalizedString("VARIANTS_SECTION_ROW", comment: "Departure place label")
        
    }
    
    func rowsCount() -> Int {
        return 1
    }
    
    func configurationFunctionAndIdentifier(owner: ScheduleController) -> (((UITableViewCell, NSIndexPath) -> UITableViewCell), String)
    {
        switch self {
        case .VariantsPlace: return (owner.configureVariantsCell, VariantsCell.cellId)
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