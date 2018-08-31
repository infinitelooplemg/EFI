//
//  DeleteMeasurerRequestParameters.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 01/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation


struct DeleteMeasurerRequestParameters:Codable {
    var ClaveLocalizacion:String?
    var UserId:String? = "fe040b94-82bf-4e09-b171-ec6e050810a4"
    //"b3f5b6d3-d53b-4c27-8ad8-4841f7b39aaf"
    var NS:String?
}
