//
//  RegisterMeasurerNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import AsyncDisplayKit

class RegisterMeasurerNode:ASScrollNode {
    var nickNameNode:MeasurerNickNameNode!
    var energyMultiplierNode:EnergyMultiplierNode!
    var voltageMultiplierNode:MeasurerVoltageMultiplierNode!
    var measurerNode:MeasurerNode!
    var saveButton:CCTBorderButtonNode!
    var measurerParameters:RegisterMeasurerRequestParameters!
    weak var delegate:RegisterMeasurerNodeDelegate?
    var alarmNode:MeasurerAlarmNode!
    var location:Location!
    var measureID:String?
    
    init(location:Location) {
        //  self.delegate = delegate
        measurerParameters = RegisterMeasurerRequestParameters()
        self.location = location
        super.init()
        
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
        setupNodes()
    }
    
    
    func setupNodes() {
        nickNameNode = MeasurerNickNameNode()
        energyMultiplierNode = EnergyMultiplierNode()
        voltageMultiplierNode = MeasurerVoltageMultiplierNode()
        measurerNode = MeasurerNode()
        
        alarmNode = MeasurerAlarmNode()
        
        saveButton = CCTBorderButtonNode(fontSize: 13, textColor: .white, with: "Guardar")
        saveButton.addTarget(self, action: #selector(save), forControlEvents: .touchUpInside)
        saveButton.style.preferredSize.height = 44
        saveButton.backgroundColor = UIColor.con100tGreenColor
        
    }
    
    @objc func save() {
        measurerParameters.ClaveLocalizacion = location.Clave
        
        guard let name = nickNameNode.measurerNickNameTextNode.attributedText?.string else {
            //            showAlert(with: "Ooops!", message: "Al parecer se te olvido nombrar a tu medidor", image: nil, for: .error)
            return
        }
        measurerParameters.NombreApodo = name
        
        
        
        if energyMultiplierNode.switchView.isOn {
            guard let primary = energyMultiplierNode.primaryTextNode.attributedText?.string, let secondary = energyMultiplierNode.secondaryTextNode.attributedText?.string else {
                //                showAlert(with: "Error", message: "Verifica que no falte algun campo para calcular su multiplicador", image: nil, for: .error)
                return
            }
            measurerParameters.CorrientePrimaria = (primary as NSString).floatValue
            measurerParameters.CorrienteSecundaria = (secondary as NSString).floatValue
            
        } else {
            measurerParameters.CorrientePrimaria = 1
            measurerParameters.CorrienteSecundaria = 1
        }
        
        if voltageMultiplierNode.switchView.isOn {
            guard let primary = voltageMultiplierNode.primaryTextNode.attributedText?.string, let secondary = voltageMultiplierNode.secondaryTextNode.attributedText?.string else {
                //                showAlert(with: "Error", message: "Verifica que no falte algun campo para calcular su multiplicador", image: nil, for: .error)
                return
            }
            measurerParameters.VoltajePrimario = (primary as NSString).floatValue
            measurerParameters.VoltajeSecundario = (secondary as NSString).floatValue
        } else {
            measurerParameters.VoltajePrimario = 1
            measurerParameters.VoltajeSecundario = 1
        }
        
        if alarmNode.switchView.isOn {
            guard let maxDemand = alarmNode.maximumDemandTextNode.attributedText?.string, let perc = alarmNode.percentageTextNode.attributedText?.string else {
                //                showAlert(with: "Error", message: "Verifica que no falta algun campo en la seccion Alarma", image: nil, for: .error)
                return
            }
            measurerParameters.AlarmaActivada = true
            measurerParameters.PotenciaMaxEsperada = (maxDemand as NSString).floatValue
            measurerParameters.PorcPotenciaMaxAlarma = (perc as NSString).floatValue
            
        } else {
            measurerParameters.AlarmaActivada = false
            measurerParameters.PotenciaMaxEsperada = 0
            measurerParameters.PorcPotenciaMaxAlarma = 0
        }
        
        guard let id = measurerNode.measurerIDNode.attributedText?.string else {
            return
        }
        
        measurerParameters.NS = id
        
        delegate?.passParametersFor(measurer: measurerParameters)
      
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let inputStack = ASStackLayoutSpec.vertical()
        inputStack.children = [nickNameNode,energyMultiplierNode,voltageMultiplierNode,measurerNode,alarmNode]
        inputStack.spacing = 8
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [inputStack,saveButton]
        contentStack.justifyContent = .spaceBetween
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets , child: contentStack)
        
        return insetSpecs
    }
}


