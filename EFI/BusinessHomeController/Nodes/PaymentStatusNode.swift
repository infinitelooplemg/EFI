//
//  PaymentStatusNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import AsyncDisplayKit
class PaymentStatusNode:CCTNode {
    var fixedChargeTitleTextNode:CTTTextNode!
    var fixedChargeTextNode:CTTTextNode!
    var energyTitleTextNode:CTTTextNode!
    var energyTextNode:CTTTextNode!
    var billableTitleTextNode:CTTTextNode!
    var billableTextNode:CTTTextNode!
    var bonusForPowerFactorTextNode:CTTTextNode!
    var bonusForPowerFactorTitleTextNode:CTTTextNode!
    var subtotalTitleTextNode:CTTTextNode!
    var subtotalTextNode:CTTTextNode!
    var IVATitleTextNode:CTTTextNode!
    var IVATextNode:CTTTextNode!
    var totalTextNode:CTTTextNode!
    var totalTitleTextNode:CTTTextNode!
    var createReportButton:CCTBorderButtonNode!
    var headerTextNode:CTTTextNode!
    var segmentedNode:ASDisplayNode!
    var segmentedControl:UISegmentedControl!
    
    override init() {
        super.init()
        setupView()
        automaticallyManagesSubnodes = true
    }
    
    func  setupView() {
        
        headerTextNode = CTTTextNode(withFontSize: 25, color: .black, with: "Estado de Cuenta")
        
        fixedChargeTitleTextNode = CTTTextNode(withFontSize: 15, color: UIColor.black, with: "Cargo Fijo:")
        fixedChargeTextNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: "468.10")
        
        energyTextNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: "208,555.09")
        energyTitleTextNode = CTTTextNode(withFontSize: 15, color: .black, with: "Energía:")
        
        billableTitleTextNode = CTTTextNode(withFontSize: 15, color: .black, with: "Demanda Facturable:")
        billableTextNode = CTTTextNode(withFontSize: 15, color: .lightGray, with: "97,712.56")
        
        bonusForPowerFactorTitleTextNode = CTTTextNode(withFontSize: 15, color: .black, with: "Bonificación F.P.")
        bonusForPowerFactorTextNode = CTTTextNode(withFontSize: 15, color: .lightGray, with: "8,151.91")
        
        subtotalTitleTextNode = CTTTextNode(withFontSize: 15, color: .black, with: "Subtotal")
        subtotalTextNode = CTTTextNode(withFontSize: 15, color: .lightGray, with: "298,583.84")
        
        IVATitleTextNode = CTTTextNode(withFontSize: 15, color: .black, with: "IVA 16%")
        IVATextNode = CTTTextNode(withFontSize: 15, color: .lightGray, with: "44,787.57")
        
        totalTitleTextNode = CTTTextNode(withFontSize: 15, color: .black, with: "Total")
        totalTextNode = CTTTextNode(withFontSize: 15, color: .lightGray, with: "343,371.416")
        
        createReportButton = CCTBorderButtonNode(fontSize: 13, textColor: .white, with: "Generar Reporte")
        createReportButton.backgroundColor = UIColor.con100tGreenColor
        
        segmentedControl = UISegmentedControl(items: ["Horaria","Ordinaria"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        
        
        segmentedNode = ASDisplayNode { [weak self]() -> UIView in
            return self!.segmentedControl
        }
        segmentedNode.style.preferredSize.height = 30
        
        segmentedNode.clipsToBounds = true
        segmentedNode.tintColor = UIColor.con100tGreenColor
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let cargoStack = CCTTitleValueHorizontalStack()
        cargoStack.children = [fixedChargeTitleTextNode,fixedChargeTextNode]
        
        
        let energiaStack = CCTTitleValueHorizontalStack()
        energiaStack.children = [energyTitleTextNode,energyTextNode]
        
        let demandaStack = CCTTitleValueHorizontalStack()
        demandaStack.children = [billableTitleTextNode,billableTextNode]
        
        let bonificacionStack = CCTTitleValueHorizontalStack()
        bonificacionStack.children = [bonusForPowerFactorTitleTextNode,bonusForPowerFactorTextNode]
        
        let subtotalStack = CCTTitleValueHorizontalStack()
        subtotalStack.children = [subtotalTitleTextNode,subtotalTextNode]
        
        let ivaStack = CCTTitleValueHorizontalStack()
        ivaStack.children = [IVATitleTextNode,IVATextNode]
        
        let totalStack = CCTTitleValueHorizontalStack()
        totalStack.children = [totalTitleTextNode,totalTextNode]
        
        
        
        let contentStack = ASStackLayoutSpec.vertical()
        
        contentStack.children = [headerTextNode,segmentedNode,cargoStack,energiaStack,demandaStack,bonificacionStack,subtotalStack,ivaStack,totalStack]
        
        contentStack.justifyContent = .spaceBetween
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpec =     ASInsetLayoutSpec(insets: insets, child: contentStack)
        insetSpec.style.flexGrow = 0
        return insetSpec
    }
    
}
