//
//  RTPowerNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//
import AsyncDisplayKit

class RTPowerNode:CCTNode  {
    var titleTextNode:CTTTextNode!
    var valueTextNode:CTTTextNode!
    var phaseStackLayout:CCTPhasesHorizontalStack!
    var activity:ElectricalVariables!
    var segmentedNode:ASDisplayNode!
    var segmentedControl:UISegmentedControl!
    var container:EnergyPower?
    let selection = UISelectionFeedbackGenerator()
    
    override init(){
        
        super.init()
        
        self.activity = ElectricalVariables.potencia
        
        automaticallyManagesSubnodes = true
        
        titleTextNode = CTTTextNode(withFontSize: 20, color: .black, with: activity.description)
        valueTextNode = CTTTextNode(withFontSize: 18, color: .lightGray, with: "120 \(activity.unitOfMeasurement)")
        phaseStackLayout = CCTPhasesHorizontalStack()
        
        segmentedControl = UISegmentedControl(items: ["Activa","Aparente","Reactiva"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changePowerFactor), for: .valueChanged)
        
        segmentedNode = ASDisplayNode { [weak self]() -> UIView in
            return self!.segmentedControl
        }
        segmentedNode.style.preferredSize.height = 30
        
        segmentedNode.clipsToBounds = true
        segmentedNode.tintColor = UIColor.con100tGreenColor
        
        
        
    }
    
    @objc func changePowerFactor(){
        selection.selectionChanged()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            updateActivePower()
        case 1:
            updateAparentPower()
        case 2:
            updateReactivePower()
        default:
            print("unused")
        }
    }
    
    func updateValues(container:EnergyPower){
        self.container = container
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            updateActivePower()
        case 1:
            updateAparentPower()
        case 2:
            updateReactivePower()
        default:
            print("unused")
        }
    }
    
    func updateActivePower(){
        guard let container = self.container else {
            return
        }
        valueTextNode.changeText(text: "\(container.PotActivaTot_PT)")
        let activephases = container.PotActiva_P
        let phases = Phases(R: activephases[0], S: activephases[1], T: activephases[2], N: nil)
        phaseStackLayout.updatePhases(phases: phases)
    }
    
    func updateReactivePower(){
        guard let container = self.container else {
            return
        }
        valueTextNode.changeText(text: "\(container.PotReactivaTot_QT)")
        let reactivephases = container.PotReactiva_Q
        let phases = Phases(R: reactivephases[0], S: reactivephases[1], T: reactivephases[2], N: nil)
        phaseStackLayout.updatePhases(phases: phases)
    }
    
    func updateAparentPower(){
        guard let container = self.container else {
            return
        }
        valueTextNode.changeText(text: "\(container.PotAparenteTot_ST)")
        let aparentphases = container.PotAparente_S
        let phases = Phases(R: aparentphases[0], S: aparentphases[1], T: aparentphases[2], N: nil)
        phaseStackLayout.updatePhases(phases: phases)
    }
    
   
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
      
        let subVerticalStack = ASStackLayoutSpec.vertical()
        subVerticalStack.spacing = 4
        subVerticalStack.children = [valueTextNode]
        subVerticalStack.alignContent = .start
        subVerticalStack.alignItems = .start
        
        
        let subHorizontalStack = ASStackLayoutSpec.horizontal()
        subHorizontalStack.children = [ subVerticalStack  ]
        subHorizontalStack.justifyContent = .spaceBetween
        subHorizontalStack.alignItems = .center
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.spacing = 4
        verticalStack.children = [ titleTextNode,segmentedNode,subHorizontalStack,phaseStackLayout]
        
        
        let insets = UIEdgeInsetsMake(8, 8, 8, 8)
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: verticalStack)
        
        
        return insetSpec
        
    }
}
