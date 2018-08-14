//
//  MapLocationsCollectionNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/10/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MapLocationsCollectionNode:ASCollectionNode {
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        backgroundColor = UIColor.clear
        style.preferredSize.height = 150
        style.preferredSize.width = UIScreen.main.bounds.width
    }
}


