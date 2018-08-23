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
    var location:Location!
    var mapNode:ASMapNode!
    
    var dummyButton:CCTBorderButtonNode!
    var dummyButton2:CCTBorderButtonNode!
    
    weak var delegate:LocationCellDelegate!
    
    
    
    init(location:Location) {
        super.init()
        self.location = location
        
        
        cornerRadius = 5
        selectionStyle = .none
        
        stateTextNode = CTTTextNode(withFontSize: 20, color: UIColor.black, with: location.Nombre!)
        stateTextNode.style.flexShrink = 1
        
        measurersButton = CCTBorderButtonNode(fontSize: 13, textColor: UIColor.con100tBlueColor, with: "Medidores")
        measurersButton.addTarget(self, action: #selector(edit), forControlEvents: .touchUpInside)
        measurersButton.addTarget(self, action: #selector(asign), forControlEvents: .touchUpInside)
        
        
        dummyButton = CCTBorderButtonNode(fontSize: 13, textColor: .con100tBlueColor, with: "Configurar")
        dummyButton.addTarget(self, action: #selector(edit), forControlEvents: .touchUpInside)
        
        
        dummyButton2 = CCTBorderButtonNode(fontSize: 13, textColor: .con100tBlueColor, with: "Estado de Cuenta")
        dummyButton2.addTarget(self, action: #selector(showPaymentStatus), forControlEvents: .touchUpInside)
        
        rateTextNode =  CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: location.NombreTarifaCRE!)
        
        mapNode = ASMapNode()
        mapNode.isLiveMap = true
        mapNode.style.preferredSize.height = 150
        mapNode.mapDelegate = self
        
        
        
        let coord = CLLocationCoordinate2DMake(19.127646044853897, -96.12060140320244)
        mapNode.region = MKCoordinateRegionMakeWithDistance(coord, 700, 700)
        
        
        
        mapNode.onDidLoad { ( _ ) in
            self.mapNode.mapView?.delegate = self
            let circle = MKCircle(center: coord, radius: 75)
            self.mapNode.mapView?.add(circle)
            self.mapNode.isUserInteractionEnabled = false
        }
        
        
        automaticallyManagesSubnodes  = true
    }
    
    @objc func showPaymentStatus(){
        delegate.showPaymentStatusFor(location: location)
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
        
        let separator = ASDisplayNode()
        separator.style.preferredSize.height = 0.5
        separator.backgroundColor = UIColor.con100tLightGrayColor
        
        
        let headerStack = ASStackLayoutSpec.horizontal()
        headerStack.children = [titleStack]
        headerStack.alignItems = .center
        headerStack.justifyContent = .spaceBetween
        
        let headerInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        let headerInsetSpecs = ASInsetLayoutSpec(insets: headerInsets, child: headerStack)
        
        let footerStack = ASStackLayoutSpec.horizontal()
        footerStack.children = [measurersButton,dummyButton2]
        footerStack.justifyContent = .spaceAround
        
        
        
        let footerInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        let footerInsetsSpecs = ASInsetLayoutSpec(insets: footerInsets, child: footerStack)
        
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [headerInsetSpecs,mapNode,separator,footerInsetsSpecs]
        contentStack.spacing = 8
        
        let display = ASDisplayNode()
        display.backgroundColor = UIColor.white
        display.cornerRadius = 5
        
        let internalInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let internalInsetSpecs = ASInsetLayoutSpec(insets: internalInsets, child: contentStack)
        
        let back = ASBackgroundLayoutSpec(child: internalInsetSpecs, background: display)
        
        
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: back)
        
        return insetSpecs
    }
}

extension LocationCellNode:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
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
