//
//  InstantActivity.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct InstantActivity:Codable {
    var NS:String
    var FH:String
    var Voltajes:[Float]
    var NFases:Int
    var Corrientes:[Float]
    var FactoresPotencia:[Float]
    var CorrNeutro:Float
    var Status:Int
    var VProm:Float
    var IProm:Float
    var FPProm:Float
    var PotActiva_P:[Float]
    var PotActivaTot_PT:Float
    var PotAparente_S:[Float]
    var PotAparenteTot_ST:Float
    var PotReactiva_Q:[Float]
    var PotReactivaTot_QT:Float
}
