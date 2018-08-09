//
//  RateForLocationRequestParameters.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct RateForLocationRequestParameters:Codable {
    var ClaveEstado:String?
    var ClaveMunicipio:String?
    var ClaveDivisionElectrica:String?
    var ClaveTarifaCre:String?
    var ClaveEmpresa = "ESB:CFE"
    
}
