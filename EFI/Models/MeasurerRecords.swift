//
//  MeasurerRecords.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/14/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct MeasurerRecords:Codable {
    var ClaveMedidor:String?
    var Registros:[MeasurerRecord]
}
