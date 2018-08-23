//
//  UserMeasurersViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 22/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class UserMeasurersViewController: ASViewController<ASTableNode> ,ASTableDataSource{
    var tableNode:ASTableNode!
    var measurers:[Measurer]!
    
    init(measurers:[Measurer]) {
        tableNode = ASTableNode()
        self.measurers = measurers
        super.init(node: tableNode)
        extendedLayoutIncludesOpaqueBars = false
        tableNode.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = UIColor.con100tBackGroundColor
        tableNode.view.separatorStyle = .none
        tableNode.allowsSelection = true
        
        navigationItem.title = "Medidores"
        
        let newLocationBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = newLocationBarButton
        
    }
    
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return measurers.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        
        let measurer = measurers[indexPath.row]
        
        
        let cellNodeBlock = { [weak self] () -> ASCellNode in
            let cellNode = UserMeasurerCellNode(measurer: measurer)
            return cellNode
        }
        
        return cellNodeBlock
        
        
    }
}



class UserMeasurerCellNode:ASCellNode {
    
    var measurerTextNode:CTTTextNode!
    var measurerModelTextNode:CTTTextNode!
    var locationTextNode:CTTTextNode!
    var activateButton:CCTBorderButtonNode!
    var measurer:Measurer!
    var showHistorialButton:CCTBorderButtonNode!
    
    
    
    init(measurer:Measurer) {
        super.init()
        selectionStyle = .none
        self.measurer = measurer
        locationTextNode = CTTTextNode(withFontSize: 20, color: .black, with: measurer.NombreLocalizacion!)
        measurerTextNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: measurer.Nombre!)
        measurerModelTextNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: (measurer.Clave)!)
        activateButton = CCTBorderButtonNode(fontSize: 13, textColor: UIColor.con100tBlueColor, with: "Monitorear")
        activateButton.addTarget(self, action: #selector(edit), forControlEvents: .touchUpInside)
        activateButton.backgroundColor = UIColor.con100tLightGrayColor
        activateButton.style.flexGrow = 0
        automaticallyManagesSubnodes  = true
        
     
    }
    
    @objc func edit(){
      closestViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func showHistorial(){
     
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let textNodesStack = ASStackLayoutSpec.vertical()
        textNodesStack.children = [locationTextNode,measurerTextNode,measurerModelTextNode]
        textNodesStack.style.flexShrink = 1
        
   
        
        let separator = ASDisplayNode()
        separator.style.preferredSize.height = 0.5
        separator.backgroundColor = UIColor.con100tLightGrayColor
        
        let contentStack = ASStackLayoutSpec.horizontal()
        contentStack.children = [textNodesStack,separator,activateButton]
        contentStack.spacing = 8
        contentStack.alignItems = .center
        
        let display = ASDisplayNode()
        display.backgroundColor = .white
        display.cornerRadius = 5
        display.style.flexGrow = 1
        
        let internalInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let internalInsetSpecs = ASInsetLayoutSpec(insets: internalInsets, child: contentStack)
        
        let overlay = ASBackgroundLayoutSpec(child: internalInsetSpecs, background: display)
        
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: overlay)
        
        return insetSpecs
    }
}





