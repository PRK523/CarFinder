//
//  SecondViewController.swift
//  CarFinder
//
//  Created by Pranoti Kulkarni on 4/8/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let locations = DataManager.sharedInstance.locations
        var annotations = [MKPointAnnotation]()
        
        for location in locations{
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotations.insert(annotation, at: annotations.count)
        }
        
        let oldannotations = mapView!.annotations
        mapView?.removeAnnotations(oldannotations)
        
        mapView?.addAnnotations(annotations)
        
        if(annotations.count > 0){
            let region = MKCoordinateRegionMake(annotations[0].coordinate, MKCoordinateSpanMake(0.1, 0.1))
            mapView?.regionThatFits(region)
        }
        mapView?.showsUserLocation = true
    }

}

