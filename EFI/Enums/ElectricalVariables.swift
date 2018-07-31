//
//  ElectricalVariables.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

enum ElectricalVariables:Int {
    case voltaje = 1
    case potencia = 7
    case factorPotencia = 3
    case corriente = 2
    case potenciaActiva = 4
    case potenciaReactiva = 5
    case potenciaAparente = 6
    
    var description: (String) {
        switch self {
        case .voltaje:
            return "Tensión"
        case .potencia :
            return "Potencia"
        case .factorPotencia :
            return "Factor de Potencia"
        case .corriente :
            return "Corriente"
        case .potenciaActiva:
            return "Potencia Activa"
        case .potenciaReactiva:
            return "Potencia Reactiva"
        case .potenciaAparente:
            return "Potencia Aparente"
        }
        
    }
    
    var unitOfMeasurement: (String) {
        switch self {
        case .voltaje:
            return "V"
        case .potencia :
            return "KVA"
        case .factorPotencia :
            return "KVA"
        case .corriente :
            return "kWh"
        case .potenciaActiva:
            return "KVA"
        case .potenciaReactiva:
            return "KVA"
        case .potenciaAparente:
            return "KVA"
        }
    }
    
    
    
}
