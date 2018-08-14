//
//  MapLocationsCollectionNodeDataManager.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/10/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MapLocationsCollectionNodeDataManager:NSObject,ASCollectionDataSource {
    
    var locations:[Location]!
    weak var cellDelegate:LocationMapCellDelegate!
    
    init(locations:[Location],cellDelegate:LocationMapCellDelegate) {
        super.init()
        self.cellDelegate = cellDelegate
        self.locations = locations
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let location = locations[indexPath.row]
        let cell = LocationsMapCell(location: location, delegate: self.cellDelegate)
        
        return cell
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
}
