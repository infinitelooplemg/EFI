//
//  MeasurerNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class MeasurerNode:CCTNode {
    
    var measurerTitleNode:CTTTextNode!
    
    var scanButton:CCTBorderButtonNode!
    weak var delegate:MeasurerNodeDelegate!
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
      
        
        measurerTitleNode = CTTTextNode(withFontSize: 13, color: .black, with: "Medidor")
        
     
        
        scanButton = CCTBorderButtonNode(fontSize: 13, textColor: .white, with: "Escanear Medidor")
        scanButton.addTarget(self, action: #selector(scan), forControlEvents: .touchUpInside)
        scanButton.backgroundColor = UIColor.con100tGreenColor
        
    }
    
    @objc func scan(){
        delegate.startMeasurerScanning()
        
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
     
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [measurerTitleNode,scanButton]
        contentStack.spacing = 4
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
}

extension MeasurerNode:MeasurerScannerDelegate {
    func scannedMeasurer(serialNumber: String) {
        print(serialNumber)
    }
}
