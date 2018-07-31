//
//  MeasurersResponse.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct MeasurersResponse:Codable {
    var Codigo:Int
    var Status:String
    var Medidores:[Measurer]
}
