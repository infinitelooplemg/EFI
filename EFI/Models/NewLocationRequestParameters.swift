//
//  NewLocationRequestParameters.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct NewLocationRequestParameters:Codable {
    var UserId:String? = "fe040b94-82bf-4e09-b171-ec6e050810a4"
    //"b3f5b6d3-d53b-4c27-8ad8-4841f7b39aaf"
    var Nombre:String?
    var ConsumoInicial:Float?
    var FinPeriodo:String?
    var InicioPeriodo:String?
    var ClaveEstado:String?
    var ClaveMunicipio:String?
    var ClaveDivisionElectrica:String?
    var ClaveTarifaCRE:String?
    var ClaveEmpresa:String?
}
