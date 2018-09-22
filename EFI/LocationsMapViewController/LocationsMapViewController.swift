//
//  LocationsMapViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class LocationsMapViewController:ASViewController<ASDisplayNode> {
    
    let contentNode:LocationsMapNode!
    
    init(locations:[Location],nertworkService:CCTApiService){
        contentNode = LocationsMapNode(locations: locations, nertworkService: nertworkService)
        super.init(node: contentNode)
        
        
    }
    
    override func viewDidLoad() {
        
        navigationItem.title = "Localizaciones"
        super.viewDidLoad()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentNode.checkMapPermissions()
        
        
    }
    
}


class LocationsMapNode:ASDisplayNode {
    
    var mapNode:LocationsMap!
    var collectionNode:ASCollectionNode!
    
    var collectionDatamanager:MapLocationsCollectionNodeDataManager!
    
    var mapDelegate:LocationsMapDelegate!
    
    weak var networkService:CCTApiService!
    
    var locationManager:CLLocationManager!
    
    init(locations:[Location],nertworkService:CCTApiService) {
        super.init()
        
        self.networkService = nertworkService
        
        mapDelegate = LocationsMapDelegate()
        
        mapNode = LocationsMap(delegate: mapDelegate)
        mapNode.mapView?.userTrackingMode = .follow
        
        collectionDatamanager = MapLocationsCollectionNodeDataManager(locations: locations, cellDelegate: self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionNode = MapLocationsCollectionNode(collectionViewLayout: layout)
        collectionNode.dataSource = collectionDatamanager
        
        automaticallyManagesSubnodes = true
        
        checkMapPermissions()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stack = ASStackLayoutSpec.vertical()
        stack.children = [collectionNode]
        stack.style.flexGrow = 1
        stack.alignItems = .center
        
        
        let relaticve = ASRelativeLayoutSpec(horizontalPosition: .start, verticalPosition: .end, sizingOption: .minimumHeight, child: stack)
        relaticve.style.flexGrow = 1
        
        let edgeInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0), child: relaticve)
        
        let layout = ASOverlayLayoutSpec(child: mapNode, overlay: edgeInsets)
        
        return layout
    }
    
    
    func checkMapPermissions(){
        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        
        switch status {
        case .authorizedWhenInUse:
            updateLocation()
        case .denied :
            askPermisionsInSettings()
        case .restricted:
            askPermisionsInSettings()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            updateLocation()
        default:
            break
        }
    }
    
    func updateLocation(){
        mapNode.mapView?.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    
    func askPermisionsInSettings(){
        let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString)
        if let url = settingsUrl {
            DispatchQueue.main.async() {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
}

extension LocationsMapNode:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let viewRegion = MKCoordinateRegionMakeWithDistance((locations.last?.coordinate)!, 800, 800)
        mapNode.mapView?.setRegion(viewRegion, animated: true)
    }
}

extension LocationsMapNode:LocationMapCellDelegate{
    func locate(location: Location) {
        
    }
    
    func edit(location: Location) {
    }
    
    func showMeasurersfor(location: Location) {
        networkService?.fetchMeasurers(for: location, completion: { [weak self] (measurers, error) in
            let vc = LocationMeasurersViewController(measurers: measurers!, location: location, networkService: self!.networkService!)
            vc.networkService = self?.networkService
            self?.closestViewController?.navigationController?.pushViewController(vc, animated: true)
        })
    }
}


