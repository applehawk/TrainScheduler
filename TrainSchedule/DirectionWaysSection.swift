//
//  ScheduleCell.swift
//  TrainSchedule
//
//  Created by Hawk on 27/02/16.
//  Copyright © 2016 Hawk. All rights reserved.
//


import UIKit

class DirectionWaysCell: UITableViewCell {
    static let cellId = "scheduleCellId"
    static let headerTitle = "Выбор направления"
    static let rowsInSection = 1
    
    @IBOutlet weak var wayLabel: UILabel!
}


enum DirectionWayRows : Int, Row {
    case DeparturePlace = 0
    case ArrivalPlace = 1
    
    static let allValues = [DeparturePlace, ArrivalPlace]
    
    func title() -> String {
        switch self {
        case DeparturePlace: return NSLocalizedString("DEPARTURE_CITY_LABEL", comment: "Departure place label")
        case ArrivalPlace: return NSLocalizedString("ARRIVAL_CITY_LABEL", comment: "Arrival place label")
        }
    }
    
    func rowsCount() -> Int {
        return DirectionWayRows.allValues.count
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
    func currentValue(owner: ScheduleController) -> Any?
    {
        return nil
    }
    func assignValue(owner: ScheduleController, value: Any?)
    {
        
    }
}