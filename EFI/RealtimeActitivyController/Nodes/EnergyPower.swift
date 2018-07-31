//
//  EnergyPower.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
struct EnergyPower:Codable {
    var PotActiva_P:[Float]
    var PotActivaTot_PT:Float
    var PotAparente_S:[Float]
    var PotAparenteTot_ST:Float
    var PotReactiva_Q:[Float]
    var PotReactivaTot_QT:Float
}
