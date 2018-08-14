//
//  NewLocationResponse.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct NewLocationResponse:Codable {
    var Codigo:Int
    var Status:String
    var Respuesta:Location
}
