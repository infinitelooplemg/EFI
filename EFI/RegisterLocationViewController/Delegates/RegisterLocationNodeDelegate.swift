//
//  RegisterLocationNodeDelegate.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
protocol RegisterLocationNodeDelegate:class {
    func save(location:Location,rate:CRERate, with rateParameters:RateForLocationRequestParameters)
}
