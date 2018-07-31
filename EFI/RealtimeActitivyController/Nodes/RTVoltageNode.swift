//
//  RTVoltageNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class RTVoltageNode:CCTNode {
    var titleTextNode:CTTTextNode!
    var valueTextNode:CTTTextNode!
    var phaseStackLayout:CCTPhasesHorizontalStack!
    var activity:ElectricalVariables!

    override init(){
        
        super.init()
        
        self.activity = ElectricalVariables.voltaje
        
        automaticallyManagesSubnodes = true
        
        titleTextNode = CTTTextNode(withFontSize: 20, color: .black, with: activity.description)
        valueTextNode = CTTTextNode(withFontSize: 18, color: .lightGray, with: "120 \(activity.unitOfMeasurement)")
        phaseStackLayout = CCTPhasesHorizontalStack()
        
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
     
        
        let subVerticalStack = ASStackLayoutSpec.vertical()
        subVerticalStack.spacing = 4
        subVerticalStack.children = [titleTextNode,valueTextNode]
        subVerticalStack.alignContent = .start
        subVerticalStack.alignItems = .start
        
        
        let subHorizontalStack = ASStackLayoutSpec.horizontal()
        subHorizontalStack.children = [ subVerticalStack  ]
        subHorizontalStack.justifyContent = .spaceBetween
        subHorizontalStack.alignItems = .center
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.spacing = 4
        verticalStack.children = [ subHorizontalStack,phaseStackLayout]
        
        
        let insets = UIEdgeInsetsMake(8, 8, 8, 8)
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: verticalStack)
        
        
        return insetSpec
        
    }
    
    func updateValues(average:Float,phases:[Float]){
        valueTextNode.changeText(text: "\(average)")
        
        let phases = Phases(R: phases[0], S: phases[1], T: phases[2], N: nil)
        
        phaseStackLayout.updatePhases(phases: phases)
    }
}
