//
//  MeasurerRecord.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/14/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct MeasurerRecord:Codable {
    var Fase1R:Float
    var Fase2T:Float
    var Fase3S:Float
    var Calculado:Float
    var HoraRegistro:String
}
