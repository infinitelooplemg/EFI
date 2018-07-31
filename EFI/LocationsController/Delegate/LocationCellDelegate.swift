//
//  LocationCellDelegate.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
protocol LocationCellDelegate: class {
    func showConfigurationFor(location:Location,fromIndexPath: IndexPath)
    func showMeasurersFor(location:Location)
}
