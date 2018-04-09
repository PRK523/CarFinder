//
//  FirstViewController.swift
//  CarFinder
//
//  Created by Pranoti Kulkarni on 4/8/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UITableViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()  //brings up authorization prompt for enable/disable location polling
    var currentLocation = CLLocation()
    
    @IBAction func addLocation(_ sender: UIBarButtonItem) {
        
        //append the value in the locations array that is managed by the Datamanager singleton
        //class
        var location: CLLocation
        
        if(CLLocationManager.authorizationStatus() != .authorizedWhenInUse){
            location = CLLocation(latitude: 32.830579, longitude: -117.153839)
        }
        else{
            location = locationManager.location!
        }
        
        DataManager.sharedInstance.locations.insert(location, at: 0)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        //check for 3 status levels
        switch(CLLocationManager.authorizationStatus()){
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            case .denied:
                let alert = UIAlertController(title: "Permissions error", message: "This app need location permission to work accurately", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: animated, completion: nil)
            case .notDetermined:
                fallthrough
            default:
                locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        cell.tag = indexPath.row
        
        //configure the cell
        
        let entry: CLLocation = DataManager.sharedInstance.locations[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss , MM-dd-yyyy"
        
        cell.textLabel?.text = "\(entry.coordinate.latitude), \(entry.coordinate.longitude)"
        
        cell.detailTextLabel?.text = dateFormatter.string(from: entry.timestamp)
        
        return cell
    }


}

