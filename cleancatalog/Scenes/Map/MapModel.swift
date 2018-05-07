//
//  MapModel.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation
import MapKit

enum MapModel {
    
    // MARK: Use cases
    
    enum CenterMap
    {
        struct Request{
        }
        struct Response{
            var coordinate: CLLocationCoordinate2D
        }
        struct ViewModel{
            var coordinate: CLLocationCoordinate2D
        }
    }
    
    enum RequestForCurrentLocation{
        struct Request{
        }
        struct Response{
            var success: Bool
        }
        struct ViewModel{
            var success: Bool
            var errorTitle: String?
            var errorMessage: String?
        }
    }
    
    enum GetCurrentLocation{
        struct Request{
            var mapView: MKMapView
        }
        struct Response{
            var success: Bool
            var error: NSError?
        }
        struct ViewModel{
            var success: Bool
            var errorTitle: String?
            var errorMessage: String?
        }
    }
    
    enum Map {
        struct Request{
        }
        struct Response {
            var items: [Item]
        }
        struct ViewModel {
            struct DisplayedItem {
                var id: String
                var coordinate: CLLocationCoordinate2D
                var label: String
            }
            var displayedTems: [DisplayedItem]
        }
    }
}
