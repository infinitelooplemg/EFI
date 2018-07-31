//
//  LocationsResponse.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 26/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct LocationsResponse:Codable {
    var Codigo:Int
    var Status:String
    var Localizaciones:[Location]
}
