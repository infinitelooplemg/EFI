//
//  MeasurerNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation

class MeasurerNode:CCTNode {
    
    var measurerTitleNode:CTTTextNode!
    var measurerIDNode:ASEditableTextNode!
    var scanButton:CCTBorderButtonNode!
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        
        measurerTitleNode = CTTTextNode(withFontSize: 13, color: .black, with: "Medidor")
        measurerIDNode = ASEditableTextNode(placeHolder: "Numero de serie")
        
        
        scanButton = CCTBorderButtonNode(fontSize: 13, textColor: .white, with: "Escanear Medidor")
        scanButton.addTarget(self, action: #selector(checkCameraPermissions), forControlEvents: .touchUpInside)
        scanButton.backgroundColor = UIColor.con100tBlueColor
        
    }
    
    @objc func scan(){
        
        let vc = MeasurerScannerViewController(delegate:self)
        closestViewController?.present(ASNavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [measurerTitleNode,measurerIDNode,scanButton]
        contentStack.spacing = 4
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
    
    @objc func checkCameraPermissions(){
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .denied:
            let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                DispatchQueue.main.async() {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }
            break
        case .authorized:
            scan()
            break
            
        case .restricted:
            print("restricted")
            break
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) { [weak self] (granted) in
                if granted {
                    self?.scan()
                } else {
                    
                }
            }
        }
    }
}

extension MeasurerNode:MeasurerScannerDelegate {
    func scannedMeasurer(serialNumber: String) {
        measurerIDNode.attributedText = NSAttributedString(string: serialNumber)
    }
}
