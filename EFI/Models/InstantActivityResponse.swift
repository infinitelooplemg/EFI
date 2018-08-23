//
//  InstantActivityResponse.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 22/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct InstantActivityResponse:Codable {
    var Codigo:Int
    var Status:String
    var Respuesta:InstantActivity?
    
}
