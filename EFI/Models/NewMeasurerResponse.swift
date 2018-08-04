//
//  NewMeasurerResponse.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 01/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct NewMeasurerResponse:Codable {
    var Codigo:Int
    var Status:String
    var Respuesta:Measurer?
    // var Respuesta:String
}

