//
//  Measurer.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct Measurer:Codable{
    var Clave:String?
    var Nombre:String?
    var Master:Bool?
    var CodigoGrupo:String?
    var NombreGrupo:String?
    var CodigoModeloMedidor:String
    var NombreModeloMedidor:String
    
    var CodigoLocalizacion:String?
    var NombreLocalizacion:String?
    
    var VoltajePrimario:Int?
    var VoltajeSecundario:Int?
    var CorrientePrimaria:Int?
    var CorrienteSecundaria:Int?
    var PotenciaMaximaEsperada:Float?
    var PorcentajePotenciaMaxima:Float?
}
