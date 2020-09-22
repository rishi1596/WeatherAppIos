//
//  ViewController.swift
//  Weather
//
//  Created by Deltecs on 22/09/20.
//  Copyright © 2020 App. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mMapView: MKMapView!
    var locManager:CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCurrentLocation()
    }
    
    func getCurrentLocation(){
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userCurrentLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: userCurrentLocation.coordinate.latitude, longitude: userCurrentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mMapView.setRegion(region, animated: true)
        
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.coordinate = CLLocationCoordinate2DMake(userCurrentLocation.coordinate.latitude, userCurrentLocation.coordinate.longitude)
        mMapView.addAnnotation(currentAnnotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Error in getting the location", error.localizedDescription)
    }
    
    func setTapGesture(){
        let gestRec = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        gestRec.numberOfTapsRequired = 1
        
        self.mMapView.addGestureRecognizer(gestRec)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        let loc = sender.location(in: mMapView)
        let coordinate = mMapView.convert(loc, toCoordinateFrom: mMapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mMapView.addAnnotation(annotation)
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let contr = storyboard.instantiateViewController(withIdentifier: "WeatherDetailsVC") as! WeatherDetailsVC
        contr.lat = String(coordinate.latitude)
        contr.long = String(coordinate.longitude)
        self.present(contr, animated: true)
        
        
//        let weather = WeatherDetailsVC()
//        weather.lat=1.1
//        weather.long=1.2
//        navigationController?.pushViewController(weather, animated: true)
//        print(coordinate.latitude)
//        print(coordinate.longitude)
    }

    
}

