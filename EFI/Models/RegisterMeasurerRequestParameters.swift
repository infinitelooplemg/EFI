//
//  RegisterMeasurerRequestParameters.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct RegisterMeasurerRequestParameters:Codable {
    
    var UserId:String? = "fe040b94-82bf-4e09-b171-ec6e050810a4"
    //"b3f5b6d3-d53b-4c27-8ad8-4841f7b39aaf"
    var NS:String?
    var NombreApodo:String?
    var ClaveLocalizacion:String?
    var ClaveGrupo:String? = "GRP:DEFAULT"
    var CorrientePrimaria:Float? = 1
    var CorrienteSecundaria:Float? = 1
    var VoltajePrimario:Float? = 1
    var VoltajeSecundario:Float? = 1
    var AlarmaActivada:Bool? = false
    var PotenciaMaxEsperada:Float? = 1
    var PorcPotenciaMaxAlarma:Float? = 1
    
}
