//
//  MeasurerDetailViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MeasurerDetailViewController: UIViewController {
    
    var  displayNode:MeasurerDetaileNode!
    
    
    
    init(measurer:Measurer) {
        super.init(nibName: nil, bundle: nil)
        displayNode = MeasurerDetaileNode(measurer: measurer)
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

class MeasurerDetaileNode:ASDisplayNode {
    
    var nameSection:MeasurerDetailNameSectionNode!
    var currentMultiplierSection:MeasurerDetailEnergyMultiplierSectionNode!
    var voltageMultiplierSection:MeasurerDetailVoltageMultiplierSectionNode!
    var identifierSection:MeasurerDetailIdentifierSectionNode!
    var alarmSection:MeasurerDetailAlarmSectionNode!
    
    init(measurer:Measurer) {
        super.init()
        automaticallyManagesSubnodes = true
        nameSection = MeasurerDetailNameSectionNode(name: measurer.Nombre!)
        identifierSection = MeasurerDetailIdentifierSectionNode(name: measurer.Clave!)
        currentMultiplierSection = MeasurerDetailEnergyMultiplierSectionNode(primary: measurer.CorrientePrimaria!, secondary: measurer.CorrienteSecundaria!)
        voltageMultiplierSection = MeasurerDetailVoltageMultiplierSectionNode(primary: measurer.VoltajePrimario!, secondary: measurer.VoltajeSecundario!)
        alarmSection = MeasurerDetailAlarmSectionNode(demandaMaxima: measurer.PotenciaMaximaEsperada!, porcentaje: measurer.PorcentajePotenciaMaxima!)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [nameSection,identifierSection,currentMultiplierSection,voltageMultiplierSection,alarmSection]
        contentStack.spacing = 32
        
        let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
}

class MeasurerDetailNameSectionNode:ASDisplayNode{
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

class MeasurerDetailIdentifierSectionNode:ASDisplayNode{
    var titleLabel:CTTTextNode!
    var nameLabel:CTTTextNode!
    
    init(name:String) {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        titleLabel = CTTTextNode(withFontSize: 15, color: .black, with: "Identificador")
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

class MeasurerDetailEnergyMultiplierSectionNode:ASDisplayNode{
    var titleLabel:CTTTextNode!
    var primaryMultiplierLabel:CTTTextNode!
    var secondaryMultiplierLabel:CTTTextNode!
    
    init(primary:Int,secondary:Int) {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        primaryMultiplierLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "Primaria: \(primary)")
        secondaryMultiplierLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "Secundaria: \(secondary)")
        titleLabel = CTTTextNode(withFontSize: 15, color: .black, with: "Multiplicador de corriente por uso de Transformador")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [titleLabel,primaryMultiplierLabel,secondaryMultiplierLabel]
        contentStack.spacing = 8
        
        let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let spectInsets = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return spectInsets
    }
}

class MeasurerDetailVoltageMultiplierSectionNode:ASDisplayNode{
    var titleLabel:CTTTextNode!
    var primaryMultiplierLabel:CTTTextNode!
    var secondaryMultiplierLabel:CTTTextNode!
    
    init(primary:Int,secondary:Int) {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        primaryMultiplierLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "Primaria: \(primary)")
        secondaryMultiplierLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "Secundaria: \(secondary)")
        titleLabel = CTTTextNode(withFontSize: 15, color: .black, with: "Multiplicador de voltaje por uso de Transformador")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [titleLabel,primaryMultiplierLabel,secondaryMultiplierLabel]
        contentStack.spacing = 8
        
        let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let spectInsets = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return spectInsets
    }
}

class MeasurerDetailAlarmSectionNode:ASDisplayNode{
    var titleLabel:CTTTextNode!
    var maximumDemandLabel:CTTTextNode!
    var percentageLabel:CTTTextNode!
    
    init(demandaMaxima:Float,porcentaje:Float) {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        maximumDemandLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "Demanda Maxima: \(demandaMaxima)")
        percentageLabel = CTTTextNode(withFontSize: 15, color: .lightGray, with: "Porcentaje: \(porcentaje)")
        titleLabel = CTTTextNode(withFontSize: 15, color: .black, with: "Alarma de Consumo")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [titleLabel,maximumDemandLabel,percentageLabel]
        contentStack.spacing = 8
        
        let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let spectInsets = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return spectInsets
    }
}
