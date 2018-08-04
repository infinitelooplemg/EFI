//
//  RegisterMeasurerNodeDelegate.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 01/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

protocol RegisterMeasurerNodeDelegate:class {
    func passParametersFor(measurer:RegisterMeasurerRequestParameters)
}
