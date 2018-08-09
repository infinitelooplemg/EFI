//
//  RegisterLocationNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import  AsyncDisplayKit
import StatusAlert

class RegisterLocationNode:ASScrollNode {
    var nameInputNode:LocationNameNode!
    var initialConsumptionTextNode:LocationInitialConNode!
    var locationPeriodNode:LocationPeriodNode!
    var locationRateNode:LocationRateNode!
    var locationMaxumumNode:LocationMaximusDemandNode!
    var saveButton:CCTBorderButtonNode!
    var networkService:CCTApiService!
    weak var delegate:RegisterLocationNodeDelegate!
    
    init(delegate:RegisterLocationNodeDelegate,networkService:CCTApiService) {
        super.init()
        self.delegate = delegate
        self.networkService = networkService
        
        backgroundColor = UIColor.con100tGrayColor
        nameInputNode = LocationNameNode()
        initialConsumptionTextNode = LocationInitialConNode()
        locationMaxumumNode = LocationMaximusDemandNode()
        locationRateNode = LocationRateNode(networkService: self.networkService)
        locationPeriodNode = LocationPeriodNode(delegate: self, startDate: nil, finishDate: nil)
        saveButton = CCTBorderButtonNode(fontSize: 15, textColor: .white, with: "Guardar")
        saveButton.style.preferredSize.height = 44
        saveButton.backgroundColor = UIColor.con100tBlueColor
        saveButton.addTarget(self, action: #selector(saveLocation), forControlEvents: .touchUpInside)
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
    }
    
    
    @objc func saveLocation()  {
        
        guard let initialConsumption = initialConsumptionTextNode.initialConsumptionTextNode.attributedText?.string, let locationName = nameInputNode.locationNmeTextNode.attributedText?.string,let maximumDemand = locationMaxumumNode.maximumDemandTextNode.attributedText?.string,    let startDate = locationPeriodNode.startDateTextNode.attributedText?.string,  let finisDate = locationPeriodNode.finishDateTextNode.attributedText?.string else {
           // showAlert(with: "Ooops!", message: "Al parecer olvidaste llenar algunos campos", image: nil, for: .error)
            return
        }
        
        
        guard let rateParameters = locationRateNode.rateParameters, let rate = locationRateNode.rate else {
           // showAlert(with: "Ooops!", message: "Al parecer olvidaste seleccionar una tarifa", image: nil, for: .error)
            
            return
        }
        
        if startDate.isEmpty || finisDate.isEmpty {
          //  showAlert(with: "Ooops!", message: "Verifica que las fechas de tu periodo se encuentren seleccionadas", image: nil, for: .error)
            return
        }
        
        
        let initialConsumptionFloatValue = (initialConsumption as NSString).floatValue
        let maximumDemandFloatValue = (maximumDemand as NSString).floatValue
        
        
        
        var location = Location()
        location.FinPeriodo = finisDate
        location.InicioPeriodo = startDate
        location.Nombre = locationName
        location.ConsumoInicial = initialConsumptionFloatValue
        location.DemandaMaxima = maximumDemandFloatValue
        location.TipoDeTarifa = rate.TipoDeTarifa
        
        delegate.save(location: location, rate: rate, with: rateParameters)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let inputStack = ASStackLayoutSpec.vertical()
        inputStack.children = [nameInputNode,initialConsumptionTextNode,locationMaxumumNode,locationRateNode,locationPeriodNode]
        inputStack.spacing = 8
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [inputStack,saveButton]
        contentStack.justifyContent = .spaceBetween
        
        let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let insetSpecs = ASInsetLayoutSpec(insets:insets, child: contentStack)
        
        return insetSpecs
    }
}







extension RegisterLocationNode:ASEditableTextNodeDelegate{
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if editableTextNode == initialConsumptionTextNode {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: text)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else {
            return false
        }
        
        return true
    }
    
}

extension RegisterLocationNode:LocationPeriodNodeDelegate{
    func initializePeriodConfiguration(dateType: DateType, previousDate: Date?) {
        let vc = DateChooserViewController(delegate: self, dateType: dateType, previousDate: previousDate)
        let nc = UINavigationController(rootViewController: vc)
        closestViewController?.present(nc, animated: true, completion: nil)
    }
}

extension RegisterLocationNode:DateChooserDelegate{
    func update(date: Date, dateType: DateType) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        let dateString = dateFormatter.string(from: date)
        if dateType == .Finish {
            locationPeriodNode.finishDate = date
            locationPeriodNode.finishDateTextNode.changeText(text: dateString)
        } else {
            locationPeriodNode.startDate = date
            locationPeriodNode.startDateTextNode.changeText(text: dateString)
        }
    }
}
