//
//  RestaurantMapData.swift
//  BookFood
//
//  Created by JohnLiu on 2017/6/18.
//  Copyright © 2017年 teamFour. All rights reserved.
//
import Foundation
import MapKit

class RestaurantMapData: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
