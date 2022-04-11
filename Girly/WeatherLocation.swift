//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Bridget Falkenhayn on 3/13/22.
//

import Foundation

class WeatherLocation: Codable
{
    var name:String
    var latitude:Double
     var longitude:Double
    
    init(name: String, latitude: Double, longitude: Double){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        
    }
        
    
}

