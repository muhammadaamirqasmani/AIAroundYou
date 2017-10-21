//
//  MapVC.swift
//  AIAroundYou
//
//  Created by admin on 06/10/2017.
//  Copyright © 2017 MuhammadAamir. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapVC: UIViewController {

    var locationManager = CLLocationManager()
    var location: CLLocation?
    var zoomLevel: Float = 17.5
    var mapView: GMSMapView!
    var camera: GMSCameraPosition!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
extension MapVC: CLLocationManagerDelegate{
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        print("Location: \(String(describing: location))")
        
        self.camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!,longitude: (location?.coordinate.longitude)!,zoom: zoomLevel, bearing: 0, viewingAngle: 0)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        marker.title = "AroundAI Here"
        marker.snippet = "AI is Arounding You"
        marker.tracksInfoWindowChanges = true
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.map = mapView
        
        //listLikelyPlaces()
        
        mapView.animate(to: camera)
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}
