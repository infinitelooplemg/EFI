//
//  PhaseIdentifier.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import UIKit
enum PhaseIdentifier {
    case R
    case S
    case T
    case N
    
    var imageDescription: (UIImage) {
        switch self {
        case .R:
            return #imageLiteral(resourceName: "RPhaseIcon")
        case .S:
            return #imageLiteral(resourceName: "SPhaseIcon")
        case .T:
            return #imageLiteral(resourceName: "TPhaseIcon")
        case .N:
            return #imageLiteral(resourceName: "NPhaseIcon")
        }
    }
}
