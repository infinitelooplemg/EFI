//
//  LocationsMapCell.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/10/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class LocationsMapCell:ASCellNode {
    
    var titleNode:CTTTextNode!
    var rateNameNode:CTTTextNode!
    var measurersButton:CCTBorderButtonNode!
    var editButton:CCTBorderButtonNode!
    var activateButton:CCTBorderButtonNode!
    var deleteButton:CTTIconButton!
    var locateButton:CTTIconButton!
    
    var location:Location!
    
    weak var delegate:LocationMapCellDelegate!
    init(location:Location,delegate:LocationMapCellDelegate) {
        self.location = location
        self.delegate = delegate
        super.init()
        
        backgroundColor = .white
        cornerRadius = 5
        
        titleNode = CTTTextNode(withFontSize: 15, color: .black, with: location.Nombre!)
        
        rateNameNode = CTTTextNode(withFontSize: 13, color: .lightGray, with: location.NombreTarifaCRE!)
        
        measurersButton = CCTBorderButtonNode(fontSize: 13, textColor: UIColor.con100tBlueColor, with: "Medidores")
        measurersButton.backgroundColor = UIColor.con100tGrayColor
        measurersButton.addTarget(self, action: #selector(showMeasurers), forControlEvents: .touchUpInside)
        
        editButton = CCTBorderButtonNode(fontSize: 13, textColor: UIColor.con100tBlueColor, with: "Editar")
        editButton.backgroundColor = UIColor.con100tGrayColor
        editButton.addTarget(self, action: #selector(editLocation), forControlEvents: .touchUpInside)
        
        activateButton = CCTBorderButtonNode(fontSize: 13, textColor: UIColor.con100tBlueColor, with: "Monitorear")
        activateButton.backgroundColor = UIColor.con100tGrayColor
        
        deleteButton = CTTIconButton(icon: #imageLiteral(resourceName: "delete"), size: 20)
        locateButton = CTTIconButton(icon: #imageLiteral(resourceName: "locate"), size: 20)
        
        
        
        automaticallyManagesSubnodes = true
    }
    
    
    @objc func showMeasurers(){
        delegate.showMeasurersfor(location: location)
    }
    
    @objc func editLocation(){
        delegate.edit(location: location)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let buttonsStack = ASStackLayoutSpec.horizontal()
        buttonsStack.children = [measurersButton,editButton,activateButton]
        buttonsStack.spacing = 4
        buttonsStack.alignItems = .center
        
        let iconButtonStack = ASStackLayoutSpec.horizontal()
        iconButtonStack.spacing = 8
        iconButtonStack.alignItems = .center
        iconButtonStack.children = [deleteButton,locateButton]
        
        let contentstack = ASStackLayoutSpec.vertical()
        contentstack.children = [titleNode,rateNameNode,buttonsStack,iconButtonStack]
        contentstack.spacing = 8
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentstack)
        
        return insetSpecs
    }
}
