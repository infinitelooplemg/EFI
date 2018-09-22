//
//  BusinessHomeNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class BusinessHomeNode: ASScrollNode {
    
    var activeEnergyConsumptionNode:BusinessEnergyConsumptionNode!
    var activeEnergyConsumptionHeaderNode:CTTTextNode!
    var activeEnergyConsumptionFooterNode:CTTTextNode!
    
    var reactiveEnergyConsumptionNode:BusinessEnergyConsumptionNode!
    var reactiveEnergyConsumptionHeaderNode:CTTTextNode!
    var reactiveEnergyConsumptionFooterNode:CTTTextNode!
    
    var powerFactorConsumptionNode:BusinessEnergyConsumptionNode!
    var powerFactorConsumptionHeaderNode:CTTTextNode!
    var powerFactorConsumptionFooterNode:CTTTextNode!
    
    var maximumDemandConsumptionNode:BusinessEnergyConsumptionNode!
    var maximumDemandConsumptionHeaderNode:CTTTextNode!
    var maximumDemandConsumptionFooterNode:CTTTextNode!
    
    var kWMaxAnoMovilNode:BusinessEnergyConsumptionNode2!
    var kWMaxAnoMovilHeaderNode:CTTTextNode!
    
    
    
    var paymentStatusNode:PaymentStatusNode!
    var localizationNode:HomeLocationNode!
    
    var energyConsumption:EnergyConsumption?
    
    init(locationNodeDelegate:HomeLocationNodeDelegate,consumption:EnergyConsumption) {
        
        super.init()
        self.energyConsumption = consumption
        
        setupView()
        
        
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
        backgroundColor = UIColor.con100tBackGroundColor
    }
    
    func setupView(){
        activeEnergyConsumptionNode = BusinessEnergyConsumptionNode(base: (energyConsumption?.EnergiaAcumP_Base)!, mid: (energyConsumption?.EnergiaAcumP_Intermedio)!, top: (energyConsumption?.EnergiaAcumP_Punta)!, total: (energyConsumption?.EnergiaTotalP)!)
        
        reactiveEnergyConsumptionNode = BusinessEnergyConsumptionNode(base: (energyConsumption?.EnergiaAcumQ_Base)!, mid: (energyConsumption?.EnergiaAcumQ_Intermedio)!, top: (energyConsumption?.EnergiaAcumQ_Punta)!, total: (energyConsumption?.EnergiaTotalQ)!)
        
        powerFactorConsumptionNode = BusinessEnergyConsumptionNode(base: (energyConsumption?.FactPot_Base)!, mid: (energyConsumption?.FactPot_Intermedio)!, top: (energyConsumption?.FactPot_Punta)!, total: (energyConsumption?.FactPot_Total)!)
        
        maximumDemandConsumptionNode = BusinessEnergyConsumptionNode(base: (energyConsumption?.MaxKW_Base)!, mid: (energyConsumption?.MaxKW_Intermedio)!, top: (energyConsumption?.MaxKW_Punta)!, total: 0)
        
        kWMaxAnoMovilNode = BusinessEnergyConsumptionNode2(dmax: (energyConsumption?.KWMax_AnoMovil)!, Qmensual: (energyConsumption?.QMensual)!)
        
        activeEnergyConsumptionHeaderNode = CTTTextNode(withFontSize: 24, color: .black, with: "Activa")
        activeEnergyConsumptionFooterNode = CTTTextNode(withFontSize: 13, color: .lightGray, with: "valores en kWh")
        activeEnergyConsumptionFooterNode.style.alignSelf = .end
        reactiveEnergyConsumptionHeaderNode = CTTTextNode(withFontSize: 24, color: .black, with: "Reactiva")
        reactiveEnergyConsumptionFooterNode = CTTTextNode(withFontSize: 13, color: .lightGray, with: "valores en kVArh")
        reactiveEnergyConsumptionFooterNode.style.alignSelf = .end
        powerFactorConsumptionHeaderNode = CTTTextNode(withFontSize: 24, color: .black, with: "Factor de Potencia")
        maximumDemandConsumptionHeaderNode = CTTTextNode(withFontSize: 24, color: .black, with: "Demanda Max.")
        maximumDemandConsumptionFooterNode = CTTTextNode(withFontSize: 13, color: .lightGray, with: "valores en kW")
        maximumDemandConsumptionFooterNode.style.alignSelf = .end
        kWMaxAnoMovilHeaderNode = CTTTextNode(withFontSize: 24, color: .black, with: "kWMaxAñoMovil")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stack = ASStackLayoutSpec.vertical()
        stack.spacing = 8
        stack.children = [activeEnergyConsumptionHeaderNode,activeEnergyConsumptionNode,activeEnergyConsumptionFooterNode,reactiveEnergyConsumptionHeaderNode,reactiveEnergyConsumptionNode,reactiveEnergyConsumptionFooterNode,powerFactorConsumptionHeaderNode,powerFactorConsumptionNode,maximumDemandConsumptionHeaderNode,maximumDemandConsumptionNode,maximumDemandConsumptionFooterNode,kWMaxAnoMovilHeaderNode,kWMaxAnoMovilNode]
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: stack)
        
        return insetSpecs
    }
}
