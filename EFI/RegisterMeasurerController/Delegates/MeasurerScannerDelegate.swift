//
//  MeasurerScannerDelegate.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

protocol  MeasurerScannerDelegate:class {
    func scannedMeasurer(serialNumber:String)
}
