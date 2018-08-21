//
//  MeasurerCellNodeDelegate.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
protocol MeasurerCellNodeDelegate:class {
    func edit(measurer:Measurer)
    func showHistorialFor(measurer:Measurer)
}
