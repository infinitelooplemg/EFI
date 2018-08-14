//
//  LocationCellNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation


import  AsyncDisplayKit

class LocationCellNode:ASCellNode {
    
    var stateTextNode:CTTTextNode!
    var measurersButton:CCTBorderButtonNode!
    var rateTextNode:CTTTextNode!
    var showMeasurersButton:CCTBorderButtonNode!
    var location:Location!
    var mapNode:ASMapNode!
    
    var dummyButton:CCTBorderButtonNode!
        var dummyButton2:CCTBorderButtonNode!
    
    weak var delegate:LocationCellDelegate!
    
    
    
    init(location:Location) {
        super.init()
        self.location = location
        
      
        
        selectionStyle = .none
        
        stateTextNode = CTTTextNode(withFontSize: 20, color: UIColor.black, with: location.Nombre!)
        stateTextNode.style.flexShrink = 1
        
        measurersButton = CCTBorderButtonNode(fontSize: 13, textColor: UIColor.con100tBlueColor, with: "Medidores")
        measurersButton.backgroundColor = UIColor.con100tLightGrayColor
        measurersButton.addTarget(self, action: #selector(edit), forControlEvents: .touchUpInside)
        measurersButton.style.height = ASDimension(unit: .auto, value: 52)
        measurersButton.cornerRadius = 5
        measurersButton.addTarget(self, action: #selector(asign), forControlEvents: .touchUpInside)
        measurersButton.style.flexGrow = 0.5
        
        dummyButton = CCTBorderButtonNode(fontSize: 11, textColor: .con100tBlueColor, with: "Editar")
        dummyButton.backgroundColor = UIColor.con100tLightGrayColor
        dummyButton.addTarget(self, action: #selector(edit), forControlEvents: .touchUpInside)
        dummyButton.style.height = ASDimension(unit: .auto, value: 52)
        dummyButton.cornerRadius = 5
        
        dummyButton2 = CCTBorderButtonNode(fontSize: 13, textColor: .white, with: "Estado de Cuenta")
        dummyButton2.backgroundColor = UIColor.con100tBlueColor
        dummyButton2.addTarget(self, action: #selector(edit), forControlEvents: .touchUpInside)
        dummyButton2.style.height = ASDimension(unit: .auto, value: 52)
        dummyButton2.cornerRadius = 5
        dummyButton2.style.flexGrow = 0.5
    
        showMeasurersButton = CCTBorderButtonNode(fontSize: 13, textColor: UIColor.con100tBlueColor, with: "Medidores")
        showMeasurersButton.backgroundColor = UIColor.con100tLightGrayColor
        
        rateTextNode =  CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: location.NombreTarifaCRE!)
        
        mapNode = ASMapNode()
        mapNode.isLiveMap = true
        mapNode.style.preferredSize.height = 150
        mapNode.mapDelegate = self
     
     
        
        let coord = CLLocationCoordinate2DMake(19.127646044853897, -96.12060140320244)
        mapNode.region = MKCoordinateRegionMakeWithDistance(coord, 700, 700)

   
    
        mapNode.onDidLoad { ( _ ) in
            print(self.mapNode.mapView)
            self.mapNode.mapView?.delegate = self
            let circle = MKCircle(center: coord, radius: 75)
            self.mapNode.mapView?.add(circle)
            self.mapNode.isUserInteractionEnabled = false
        
        }
    
    
        automaticallyManagesSubnodes  = true
    }
    
  
    @objc func asign(){
        delegate.showMeasurersFor(location: location)
    }
    @objc func edit() {
        delegate.showConfigurationFor(location: location, fromIndexPath: indexPath!)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let titleStack = ASStackLayoutSpec.vertical()
        titleStack.children = [stateTextNode,rateTextNode]
        titleStack.spacing = 2
        titleStack.style.flexShrink = 1
  
    
        let headerStack = ASStackLayoutSpec.horizontal()
        headerStack.children = [titleStack]
        headerStack.alignItems = .center
        headerStack.justifyContent = .spaceBetween
        
        let headerInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        let headerInsetSpecs = ASInsetLayoutSpec(insets: headerInsets, child: headerStack)
        
        let footerStack = ASStackLayoutSpec.horizontal()
        footerStack.children = [measurersButton,dummyButton2]
        footerStack.spacing = 8
        
        
        
        let footerInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        let footerInsetsSpecs = ASInsetLayoutSpec(insets: footerInsets, child: footerStack)
        
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [headerInsetSpecs,mapNode,footerInsetsSpecs]
        contentStack.spacing = 4
        
        let display = ASDisplayNode()
        display.backgroundColor = UIColor.white
     
        let internalInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let internalInsetSpecs = ASInsetLayoutSpec(insets: internalInsets, child: contentStack)
        
        let back = ASBackgroundLayoutSpec(child: internalInsetSpecs, background: display)
        
        let insets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: back)
        
        return insetSpecs
    }
}

extension LocationCellNode:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("holaaa")
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.con100tBlueColor
            circle.fillColor = UIColor.con100tBlueColor.withAlphaComponent(0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return MKPolylineRenderer()
        }

    }
}
