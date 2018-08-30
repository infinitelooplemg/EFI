//
//  LocationDetailViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/28/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class LocationDetailViewController: UIViewController {
    
    var  displayNode:LocationDetailNode!
    
    
    
    init(location:Location) {
        super.init(nibName: nil, bundle: nil)
        displayNode = LocationDetailNode(location: location)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        title = "Detalles"
        navigationController?.navigationBar.isTranslucent = false
        
        view.backgroundColor = UIColor.con100tBackGroundColor
        
        setNavigationItems()
        view.addSubnode(displayNode)
        
        view.layoutIfNeeded()
    }
    
    func setNavigationItems(){
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.setLeftBarButtonItems([doneItem], animated: true)
    }
    
    @objc func done(){
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        displayNode.view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            displayNode.view.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            displayNode.view.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            displayNode.view.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            displayNode.view.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        } else {
            displayNode.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            displayNode.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            displayNode.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            displayNode.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
}

class LocationDetailNode:ASDisplayNode{
    
    var nameSection:LocationDetailNameSection!
    var initialConcumptionSection:LocationDetailInitialConsumptionSection!
    var maximumDemandSection:LocationDetailMaximumDemandSection!
    var rateSection:LocationDetailRateSection!
    var periodSection:LocationDetailPeriodSection!
    
    init(location:Location) {
        super.init()
        nameSection = LocationDetailNameSection(name: location.Nombre!)
        initialConcumptionSection = LocationDetailInitialConsumptionSection(initialConsumption: location.ConsumoInicial!)
        maximumDemandSection = LocationDetailMaximumDemandSection(initialConsumption: location.DemandaMaxima!)
        rateSection = LocationDetailRateSection(rate: location.NombreTarifaCRE!)
        periodSection = LocationDetailPeriodSection(startDate: location.InicioPeriodo!, finishDate: location.FinPeriodo!)
        backgroundColor = UIColor.con100tBackGroundColor
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [nameSection,initialConcumptionSection,maximumDemandSection,rateSection,periodSection]
        contentStack.spacing = 32
       
        let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let spectInsets = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return spectInsets
    }
}

class LocationDetailNameSection:ASDisplayNode{
    
    var titleLabel:CTTTextNode!
    var nameLabel:CTTTextNode!
    
    init(name:String) {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        titleLabel = CTTTextNode(withFontSize: 15, color: .black, with: "Nombre")
        nameLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: name)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec.horizontal()
        contentLayout.justifyContent = .spaceBetween
        contentLayout.children = [titleLabel,nameLabel]
        contentLayout.alignItems = .center
        
        let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentLayout)
        
        return insetSpecs
    }
}

class LocationDetailInitialConsumptionSection:ASDisplayNode{
    var titleLabel:CTTTextNode!
    var initialConsumptionLabel:CTTTextNode!
    
    init(initialConsumption:Float) {
        super.init()
        backgroundColor = .white
        automaticallyManagesSubnodes = true
        titleLabel = CTTTextNode(withFontSize: 15, color: .black, with: "Consumo Inicial")
        initialConsumptionLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "\(initialConsumption)")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec.horizontal()
        contentLayout.justifyContent = .spaceBetween
        contentLayout.children = [titleLabel,initialConsumptionLabel]
        contentLayout.alignItems = .center
        
        let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentLayout)
        
        return insetSpecs
    }
}

class LocationDetailMaximumDemandSection:ASDisplayNode{
    var titleLabel:CTTTextNode!
    var initialConsumptionLabel:CTTTextNode!
    
    init(initialConsumption:Float) {
        super.init()
        backgroundColor = .white
        automaticallyManagesSubnodes = true
        titleLabel = CTTTextNode(withFontSize: 15, color: .black, with: "Demanda Máxima")
        initialConsumptionLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "\(initialConsumption)")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec.horizontal()
        contentLayout.justifyContent = .spaceBetween
        contentLayout.children = [titleLabel,initialConsumptionLabel]
        contentLayout.alignItems = .center
        
        let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentLayout)
        
        return insetSpecs
    }
}

class LocationDetailRateSection:ASDisplayNode{
    var titleLabel:CTTTextNode!
    var initialConsumptionLabel:CTTTextNode!
    
    init(rate:String) {
        super.init()
        backgroundColor = .white
        automaticallyManagesSubnodes = true
        titleLabel = CTTTextNode(withFontSize: 15, color: .black, with: "Tarifa")
        initialConsumptionLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: rate)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec.horizontal()
        contentLayout.justifyContent = .spaceBetween
        contentLayout.children = [titleLabel,initialConsumptionLabel]
        contentLayout.alignItems = .center
        
        let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentLayout)
        
        return insetSpecs
    }
}

class LocationDetailPeriodSection:ASDisplayNode{
    var titleLabel:CTTTextNode!
    var startDateLabel:CTTTextNode!
    var finishDateLabel:CTTTextNode!
    
    init(startDate:String,finishDate:String) {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        startDateLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "Inicia: \(startDate)")
        finishDateLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "Finaliza: \(finishDate)")
        titleLabel = CTTTextNode(withFontSize: 15, color: .black, with: "Periodo Comprendido")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [titleLabel,startDateLabel,finishDateLabel]
        contentStack.spacing = 8
        
        let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let spectInsets = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return spectInsets
    }
}
