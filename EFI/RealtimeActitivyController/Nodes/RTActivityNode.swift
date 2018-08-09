//
//  RTActivityNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class RTActivityNode:ASScrollNode {
    
    var voltageNode:RTVoltageNode!
    var energyNode:RTEnergyNode!
    var powerFactorNode:RTPowerFactorNode!
    var powerNode:RTPowerNode!
    var activeNode:RTActivelMeasurerNode!
    
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
        voltageNode = RTVoltageNode()
        energyNode = RTEnergyNode()
        powerFactorNode = RTPowerFactorNode()
        powerNode =  RTPowerNode()
        activeNode = RTActivelMeasurerNode()
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        
        
        let instantActivitiesStack = ASStackLayoutSpec.vertical()
     
        instantActivitiesStack.spacing = 8
        
        instantActivitiesStack.children = [activeNode,voltageNode,energyNode,powerFactorNode,powerNode]
        
        
        let inset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let insetLayoutSpec = ASInsetLayoutSpec(insets: inset, child: instantActivitiesStack)
        
        return insetLayoutSpec
        
    }
    
    
    func updateValues(RTActivity:InstantActivity){
        voltageNode.updateValues(average: RTActivity.VProm, phases: RTActivity.Voltajes)
        energyNode.updateValues(average: RTActivity.IProm, phases: RTActivity.Corrientes,neutro:RTActivity.CorrNeutro)
        powerFactorNode.updateValues(average: RTActivity.FPProm, phases: RTActivity.FactoresPotencia)
        
        let powerContainer = EnergyPower(PotActiva_P: RTActivity.PotActiva_P, PotActivaTot_PT: RTActivity.PotActivaTot_PT, PotAparente_S: RTActivity.PotAparente_S, PotAparenteTot_ST: RTActivity.PotAparenteTot_ST, PotReactiva_Q: RTActivity.PotReactiva_Q, PotReactivaTot_QT: RTActivity.PotReactivaTot_QT)
        
        powerNode.updateValues(container: powerContainer)
        
    }
}
