//
//  DataManager.swift
//  CarFinder
//
//  Created by Pranoti Kulkarni on 4/8/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import Foundation
import CoreLocation

//manages list of cllocation objects as a strong property of class
class DataManager{
    static let sharedInstance = DataManager()
    var locations: [CLLocation]
    
    private init() {
        locations = [CLLocation]()
    }
    
}
