//
//  MapIntercator.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation
import MapKit

protocol MapBusinessLogic {
    // Here we put business logic
    func getItems(request: MapModel.Map.Request)
    func getCurrentLocation(request: MapModel.GetCurrentLocation.Request)
    func requestForCurrentLocation(request: MapModel.RequestForCurrentLocation.Request)
    func centerMap(request: MapModel.CenterMap.Request)
}

protocol MapDataStore {
    var items: [Item]? { get }
}

class MapInteractor: NSObject, MapBusinessLogic, MapDataStore, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var items: [Item]?
    var presenter: MapPresentationLogic?
    let worker = LoginWorker()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?

     var centerMapFirstTime = false
    
    func getItems(request: MapModel.Map.Request) {
        if let items = items {
            let response = MapModel.Map.Response(items: items)
            presenter?.presentItems(response: response)
        }
    }
    
    // MARK: - MapBusinessLogic implementation -
    
    func getCurrentLocation(request: MapModel.GetCurrentLocation.Request) {
        request.mapView.delegate = self
    }
    
    func requestForCurrentLocation(request: MapModel.RequestForCurrentLocation.Request) {
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.showsBackgroundLocationIndicator = true
        
        locationManager.startUpdatingLocation()
        
    }
    
    func centerMap(request: MapModel.CenterMap.Request) {
        if !centerMapFirstTime, let currentLocation = currentLocation {
            let response = MapModel.CenterMap.Response(coordinate: currentLocation.coordinate)
            presenter?.presentCenterMap(response: response)
            centerMapFirstTime = true
        }
    }
    
    // MARK: - CLLocationManagerDelegate methods implementation -
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var response: MapModel.RequestForCurrentLocation.Response
        switch status {
        case .authorizedWhenInUse:
            response = MapModel.RequestForCurrentLocation.Response(success: true)
        case .authorizedAlways:
            response = MapModel.RequestForCurrentLocation.Response(success: true)
        case .restricted, .denied:
            response = MapModel.RequestForCurrentLocation.Response(success: false)
        default:
            return
        }
        presenter?.presentRequestForCurrentLocation(response: response)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        print("Location lon=\(currentLocation?.coordinate.longitude) lat=\(currentLocation?.coordinate.latitude)")
        let response = MapModel.GetCurrentLocation.Response(success: true, error: nil)
        presenter?.presentGetCurrentLocation(response: response)
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        currentLocation = nil
        let response = MapModel.GetCurrentLocation.Response(success: false, error: error as NSError)
        presenter?.presentGetCurrentLocation(response: response)
    }
}
