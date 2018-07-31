//
//  LocationCellNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation


import  AsyncDisplayKit

class LocationCellNode:ASCellNode {
    
    var stateTextNode:CTTTextNode!
    var editButtonNode:CCTBorderButtonNode!
    var rateTextNode:CTTTextNode!
    var asignButtNode:CCTBorderButtonNode!
    var location:Location!
    
    weak var delegate:LocationCellDelegate!
    
    
    
    init(location:Location) {
        super.init()
        self.location = location
        
        backgroundColor = .white
        
        selectionStyle = .none
        
        stateTextNode = CTTTextNode(withFontSize: 20, color: UIColor.black, with: location.Nombre!)
        
        editButtonNode = CCTBorderButtonNode(fontSize: 13, textColor: .white, with: "Detalles")
        editButtonNode.backgroundColor = UIColor.con100tGreenColor
        editButtonNode.addTarget(self, action: #selector(edit), forControlEvents: .touchUpInside)
        
        asignButtNode = CCTBorderButtonNode(fontSize: 13, textColor: .white, with: "Medidores")
        asignButtNode.backgroundColor = UIColor.con100tGreenColor
        asignButtNode.addTarget(self, action: #selector(asign), forControlEvents: .touchUpInside)
        
        rateTextNode =  CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: location.NombreTarifaCRE!)
 
        automaticallyManagesSubnodes  = true
    }
    
    @objc func asign(){
        delegate.showMeasurersFor(location: location)
    }
    @objc func edit() {
        delegate.showConfigurationFor(location: location, fromIndexPath: indexPath!)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [stateTextNode,rateTextNode]
        verticalStack.spacing = 4
        verticalStack.style.flexShrink = 1
        
        let buttonVerticalStack = ASStackLayoutSpec.vertical()
        //  buttonVerticalStack.children = [editButtonNode,asignButtNode]
        buttonVerticalStack.children = [asignButtNode]
        buttonVerticalStack.spacing = 4
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.children = [verticalStack,buttonVerticalStack]
        horizontalStack.alignItems = .center
        horizontalStack.justifyContent = .spaceBetween
        
        let display = ASDisplayNode()
        display.backgroundColor = .white
        display.borderWidth = 0.5
        display.borderColor = UIColor.lightGray.cgColor
        display.style.flexGrow = 1
        
        let internalInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let internalInsetSpecs = ASInsetLayoutSpec(insets: internalInsets, child: horizontalStack)
        
        let overlay = ASBackgroundLayoutSpec(child: internalInsetSpecs, background: display)
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: overlay)
        
        return insetSpecs
    }
}
