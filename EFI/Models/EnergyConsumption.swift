//
//  EnergyConsumption.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 10/09/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

struct EnergyConsumption:Codable {
    var EnergiaAcumP_Base:Double
    var EnergiaAcumP_Intermedio:Double
    var EnergiaAcumP_Punta:Double
    var EnergiaTotalP:Double
    var EnergiaAcumQ_Base:Double
    var EnergiaAcumQ_Intermedio:Double
    var EnergiaAcumQ_Punta:Double
    var EnergiaTotalQ:Double
    var FactPot_Base:Double
    var FactPot_Intermedio:Double
    var FactPot_Punta:Double
    var FactPot_Total:Double
    var MaxKW_Base:Double
    var MaxKW_Intermedio:Double
    var MaxKW_Punta:Double
    var KWMax_AnoMovil:Double
    var QMensual:Double
}
