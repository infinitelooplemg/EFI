//
//  LocalizationNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import  AsyncDisplayKit
class HomeLocationNode:CCTNode{
    
    var locationTextNode:CTTTextNode!
    var rateTextNode:CTTTextNode!
    var headerTextNode:CTTTextNode!
    var mapNode:ASMapNode!
    var seeLocationsButtons:CCTBorderButtonNode!
    var chooseRateButtonNode:CCTBorderButtonNode!
    
    weak var delegate:HomeLocationNodeDelegate?
    
    init(delegate:HomeLocationNodeDelegate) {
        super.init()
        self.delegate = delegate
        mapNode = ASMapNode()
        mapNode.style.preferredSize = CGSize(width: 300.0, height: 300.0)
        let coord = CLLocationCoordinate2DMake(19.127646044853897, -96.12060140320244)
        mapNode.region = MKCoordinateRegionMakeWithDistance(coord, 20000, 20000)
        
        
        headerTextNode = CTTTextNode(withFontSize: 25, color: .black, with: "Ubicación Actual")
        locationTextNode = CTTTextNode(withFontSize: 20, color: .black, with: "Itver")
        rateTextNode = CTTTextNode(withFontSize: 20, color: .black, with:"GDMTH")
        
        chooseRateButtonNode = CCTBorderButtonNode(fontSize: 11, textColor: .white, with: "Localizaciones")
        chooseRateButtonNode.backgroundColor = UIColor.con100tGreenColor
        chooseRateButtonNode.addTarget(self, action: #selector(showLocations), forControlEvents: .touchUpInside)
       
        automaticallyManagesSubnodes = true
        clipsToBounds = true
    }
    
    
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.alignItems = .center
        horizontalStack.justifyContent = .spaceBetween
        horizontalStack.children = [locationTextNode,rateTextNode]
        
        let horizontalSubStack = ASStackLayoutSpec.horizontal()
        horizontalSubStack.alignItems = .center
        horizontalSubStack.justifyContent = .spaceBetween
        horizontalSubStack.children = [headerTextNode,chooseRateButtonNode]
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.spacing = 4
        verticalStack.children = [horizontalSubStack,horizontalStack]
        
        let inset = UIEdgeInsetsMake(8, 8, 8, 8)
        let insetSpec =  ASInsetLayoutSpec(insets: inset, child: verticalStack)
        
    
        let back = ASBackgroundLayoutSpec(child: insetSpec, background: mapNode)
        
        
        
        return back
    }
    
    @objc func showLocations(){
        delegate?.showLocations()
    }
}
