//
//  MapViewController.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import UIKit
import MapKit

protocol MapDisplayLogic: class {
    func displayMap(viewModel: MapModel.Map.ViewModel)
    func displayRequestForCurrentLocation(viewModel: MapModel.RequestForCurrentLocation.ViewModel)
    func displayGetCurrentLocation(viewModel: MapModel.GetCurrentLocation.ViewModel)
    func displayCenterMap(viewModel: MapModel.CenterMap.ViewModel)
}

class MapViewController: UIViewController, MapDisplayLogic {
    

    // MARK: - View Outlets and Actions -
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties -
    
    var interactor: MapBusinessLogic?
    var router: (NSObjectProtocol & MapRoutingLogic & MapDataPassing)?
    
    // MARK: - Object lifecycle -
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        let viewController = self
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        let router = MapRouter()
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestForCurrentLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func displayMap(viewModel: MapModel.Map.ViewModel) {
        // Show view model on map screen
    }
    
    func displayRequestForCurrentLocation(viewModel: MapModel.RequestForCurrentLocation.ViewModel) {
        if viewModel.success {
            mapView.showsUserLocation = true
            getCurrentLocation()
        } else {
            print("Here is error message description: \(viewModel.errorMessage ?? "no error")")
        }
    }
    
    func displayGetCurrentLocation(viewModel: MapModel.GetCurrentLocation.ViewModel) {
        if viewModel.success {
            print("Got current location with \(viewModel.success)")
            centerMap()
        } else {
            print("Error for getting of current location: \(viewModel.errorMessage ?? "no error")")
        }
    }
    
    func displayCenterMap(viewModel: MapModel.CenterMap.ViewModel) {
        mapView.setCenter(viewModel.coordinate, animated: true)
    }
    
    // MARK: View Helpers
    
    func getCurrentLocation() {
        let request = MapModel.GetCurrentLocation.Request(mapView: mapView)
        interactor?.getCurrentLocation(request: request)
    }

    func requestForCurrentLocation() {
        let request = MapModel.RequestForCurrentLocation.Request()
        interactor?.requestForCurrentLocation(request: request)
    }
    
    func centerMap() {
        let request = MapModel.CenterMap.Request()
        interactor?.centerMap(request: request)
    }
    
}
