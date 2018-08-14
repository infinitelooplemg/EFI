//
//  LocationMapCellDelegate.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/10/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

protocol LocationMapCellDelegate:class {
    func edit(location:Location)
    func showMeasurersfor(location:Location)
    func locate(location:Location)
}
