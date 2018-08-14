//
//  LocationsMap.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/10/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class LocationsMap: ASMapNode {
    init(delegate:MKMapViewDelegate) {
        super.init()
        self.mapDelegate = delegate
        isLiveMap = true
        mapView?.showsUserLocation = true
        style.preferredSize = CGSize(width: 100, height: 100)
        
    }
}
