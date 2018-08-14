//
//  LocationRateNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class LocationRateNode:CCTNode {
    
    var rateTextNode:CTTTextNode!
    var rateTitleNode:CTTTextNode!
    var chooseRateButton:CCTBorderButtonNode!
    weak var networkService:CCTApiService!
    var rateParameters:RateForLocationRequestParameters?
    var rate:CRERate?
    
    init(networkService:CCTApiService) {
        super.init()
        self.networkService = networkService
        automaticallyManagesSubnodes = true
        rateTextNode = CTTTextNode(withFontSize: 15, color: .lightGray, with: "Sin seleccionar")
        rateTitleNode = CTTTextNode(withFontSize: 15, color: .black, with: "Tarifa")
        chooseRateButton = CCTBorderButtonNode(fontSize: 15, textColor: UIColor.con100tBlueColor, with: "Selecciona una Tarifa")
        chooseRateButton.addTarget(self, action: #selector(chooseRate), forControlEvents: .touchUpInside)
    }
    
    @objc func chooseRate(){
        networkService.fetchStates { [weak self](states, error) in
            if error != nil {
                return
            }

            let vc = StatesViewController(delegate: self!, networkService: (self?.networkService)!, states: states!)
            self?.closestViewController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let labelStack = ASStackLayoutSpec.horizontal()
        labelStack.children = [rateTitleNode,rateTextNode]
        labelStack.alignItems = .center
        labelStack.justifyContent = .spaceBetween
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [labelStack,chooseRateButton]
        contentStack.spacing = 4
        
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
}

extension LocationRateNode:RateSelectionDelegate{
    func rateSelected(rate: CRERate, parameters: RateForLocationRequestParameters!) {
        rateTextNode.changeText(text: rate.Nombre)
        rateParameters = parameters
        self.rate = rate
    }
}
