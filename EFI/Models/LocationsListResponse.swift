//
//  LocationsListResponse.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 22/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct LocationsListRequestParameters:Codable {
     var UserId:String? = "b3f5b6d3-d53b-4c27-8ad8-4841f7b39aaf"
}

struct LocationsListResponse:Codable {
    var Codigo:Int
    var Status:String
    var Respuesta:[Measurer]?
}
