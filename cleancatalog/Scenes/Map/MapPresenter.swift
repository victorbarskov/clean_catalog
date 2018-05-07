//
//  MapPresenter.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation
import MapKit

protocol MapPresentationLogic {
    // Here we implement presentation logic
    func presentItems(response: MapModel.Map.Response)
    func presentRequestForCurrentLocation(response: MapModel.RequestForCurrentLocation.Response)
    func presentGetCurrentLocation(response: MapModel.GetCurrentLocation.Response)
    func presentCenterMap(response: MapModel.CenterMap.Response)
}

class MapPresenter: MapPresentationLogic {
    
    weak var viewController: MapDisplayLogic?
    
    func presentItems(response: MapModel.Map.Response) {
    
        // This coordinate as na example
        let coordinate = CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
        
        var displayedItems: [MapModel.Map.ViewModel.DisplayedItem] = []
        for item in response.items {
            let displayedItem = MapModel.Map.ViewModel.DisplayedItem(id: item.id ?? "", coordinate: coordinate, label: item.name ?? "")
            displayedItems.append(displayedItem)
        }
        let viewModel = MapModel.Map.ViewModel(displayedTems: displayedItems)
        viewController?.displayMap(viewModel: viewModel)
        
    }
    
    func presentRequestForCurrentLocation(response: MapModel.RequestForCurrentLocation.Response) {
        var viewModel: MapModel.RequestForCurrentLocation.ViewModel
        if response.success {
            viewModel = MapModel.RequestForCurrentLocation.ViewModel(success: true, errorTitle: nil, errorMessage: nil)
        } else {
            viewModel = MapModel.RequestForCurrentLocation.ViewModel(success: false, errorTitle: "Location Disabled", errorMessage: "Please enable location services in the Settings app.")
        }
        viewController?.displayRequestForCurrentLocation(viewModel: viewModel)
    }
    
    func presentGetCurrentLocation(response: MapModel.GetCurrentLocation.Response) {
        var viewModel: MapModel.GetCurrentLocation.ViewModel
        if response.success {
            viewModel = MapModel.GetCurrentLocation.ViewModel(success: true, errorTitle: nil, errorMessage: nil)
        } else {
            let errorTitle = "Error"
            let errorMessage: String?
            if response.error?.code == CLError.locationUnknown.rawValue {
                errorMessage = "Your location could not be determined."
            } else {
                errorMessage = response.error?.localizedDescription
            }
            viewModel = MapModel.GetCurrentLocation.ViewModel(success: false, errorTitle: errorTitle, errorMessage: errorMessage)
        }
        viewController?.displayGetCurrentLocation(viewModel: viewModel)
    }
    
    func presentCenterMap(response: MapModel.CenterMap.Response) {
        let viewModel = MapModel.CenterMap.ViewModel(coordinate: response.coordinate)
        viewController?.displayCenterMap(viewModel: viewModel)
    }
    
}
