//
//  RTActivelMeasurerNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class RTActivelMeasurerNode:CCTNode  {
    
    var descriptionNode:CTTTextNode!
    var measurerNameNode:CTTTextNode!
    var locationNameNode:CTTTextNode!
    
    var currentMeasurer:Measurer?
    var location:Location?
    var changeMeasurerButton:CCTBorderButtonNode!
    
    weak var delegate:ActiveMeasurerNodeDelegate?
    
    
    init(delegate:ActiveMeasurerNodeDelegate,currentMeasurer:Measurer?) {
        super.init()
        self.currentMeasurer = currentMeasurer
        automaticallyManagesSubnodes = true
        self.delegate = delegate
        
        if (self.currentMeasurer != nil) {
            locationNameNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: (currentMeasurer?.NombreLocalizacion!)!)
            measurerNameNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: (currentMeasurer?.Nombre!)!)
            changeMeasurerButton = CCTBorderButtonNode(fontSize: 13, textColor: .con100tBlueColor, with: "Cambiar")
        } else {
            locationNameNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: "Sin seleccionar")
            measurerNameNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: " ")
            changeMeasurerButton = CCTBorderButtonNode(fontSize: 13, textColor: .con100tBlueColor, with: "Seleccionar")
        }
        
        descriptionNode = CTTTextNode(withFontSize: 15, color: UIColor.black, with: "Medidor")
        
        
        
        changeMeasurerButton.backgroundColor = UIColor.con100tGrayColor
        changeMeasurerButton.addTarget(self, action: #selector(showMeasurers), forControlEvents: .touchUpInside)
        
    }
    
    func updateLabels(measurer:Measurer){
        locationNameNode.changeText(text: measurer.NombreLocalizacion!)
        measurerNameNode.changeText(text: measurer.Nombre!)
    }
    
    @objc func showMeasurers(){
        delegate?.showMeasurers()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let textStack = ASStackLayoutSpec.vertical()
        textStack.children = [descriptionNode,locationNameNode,measurerNameNode]
        textStack.spacing = 4
        
        let contentStack = ASStackLayoutSpec.horizontal()
        contentStack.children = [textStack,changeMeasurerButton]
        contentStack.alignItems = .center
        contentStack.justifyContent = .spaceBetween
        
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
    
}
