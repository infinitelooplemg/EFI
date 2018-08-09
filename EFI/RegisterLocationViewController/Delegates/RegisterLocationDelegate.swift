//
//  RegisterLocationDelegate.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

protocol RegisterLocationDelegate:class {
    func locationAdded(location:Location,rate:CRERate)
}
