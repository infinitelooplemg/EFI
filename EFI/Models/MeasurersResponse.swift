//
//  MeasurersResponse.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct MeasurersResponse:Codable {
    var Codigo:Int
    var Status:String
    var Medidores:[Measurer]?
}
