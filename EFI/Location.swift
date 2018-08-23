//
//  Location.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 26/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct Location:Codable {
    var Clave:String?
    var Nombre:String?
    var InicioPeriodo:String?
    var FinPeriodo:String?
    var ConsumoInicial:Float?
    var ClaveTarifaCRE:String?
    var NombreTarifaCRE:String?
    var DemandaMaxima:Float?
    var TipoDeTarifa:Int?
    var longitude:Double?
    var latitude:Double?
    
 
}
