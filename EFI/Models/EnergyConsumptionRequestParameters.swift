//
//  EnergyConsumptionRequestParameters.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 10/09/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct EnergyConsumptionRequestParameters:Codable {
    var ClaveLocalizacion:String?
    var UserId:String? = "fe040b94-82bf-4e09-b171-ec6e050810a4"
    var FechaInicio:String? = "2018-01-09"
    var FechaFin:String? = "2018-30-09"
}


struct EnergyConsumptionResponse:Codable {
    var Codigo:Int
    var Status:String
    var Respuesta:EnergyConsumption
}
