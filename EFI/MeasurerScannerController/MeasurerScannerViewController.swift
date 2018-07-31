//
//  MeasurerScannerViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation


import UIKit
import AVFoundation
class MeasurerScannerViewController:UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var captureView:UIView?
    var captureStatusView:CaptureStatusView?
    var recognized = false
    weak var delegate:MeasurerScannerDelegate!
    
    init(delegate:MeasurerScannerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.con100tLightGrayColor
        initializeCameraSession()
        setupCameraViews()
        
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.setRightBarButton(cancelButton, animated: true)
        view.layoutIfNeeded()
        
    }
    
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    
    
    
    
    func  setupCameraViews() {
        
        captureView = UIView()
        captureStatusView = CaptureStatusView()
        view.addSubview(captureView!)
        view.addSubview(captureStatusView!)
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        captureView?.layer.addSublayer(videoPreviewLayer!)
        captureView?.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func initializeCameraSession() {
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
            captureSession?.startRunning()
        } catch {
            print(error)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            
            captureView?.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            captureView?.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            captureView?.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            captureView?.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            
            
            captureStatusView?.leadingAnchor.constraint(equalTo: guide.leadingAnchor,constant: 16).isActive = true
            captureStatusView?.bottomAnchor.constraint(equalTo: guide.bottomAnchor,constant: -16).isActive = true
            captureStatusView?.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant: -16).isActive = true
            captureStatusView?.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
        } else {
            
            
            captureView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            captureView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            captureView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            captureView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            captureStatusView?.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
            captureStatusView?.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -16).isActive = true
            captureStatusView?.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
            captureStatusView?.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        videoPreviewLayer?.frame = (captureView?.bounds)!
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                //  messageLabel.text = metadataObj.stringValue
                if !recognized {
                    recognized = true
                    
                    delegate.scannedMeasurer(serialNumber: metadataObj.stringValue!)
                    dismiss(animated: true, completion: nil)
                    
                }
                
            }
        }
    }
    
    
    
    
    
}

class CaptureStatusView:UIView {
    var label:UILabel?
    var borderView:UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.con100tLightGrayColor
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
        
        
        layer.cornerRadius = 5
        clipsToBounds = true
        setupLayout()
        layoutIfNeeded()
    }
    
    func setupView(){
        label = UILabel()
        label?.text = "Reconociendo..."
        label?.font = UIFont.boldSystemFont(ofSize: 25)
        label?.textColor = UIColor.lightGray
        label?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label!)
        
        
        
    }
    
    func changeStatus(status:String) {
        label?.text = status
    }
    func  setupLayout() {
        
        
        
        label?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        label?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        label?.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        label?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



