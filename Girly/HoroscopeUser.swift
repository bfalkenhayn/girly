//
//  HoroscopeUser.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/11/22.
//

import Foundation

class HoroscopeUser: Codable {
    var starSign: String
    var name: String
    var signNumber: Int
    
    init(starSign: String, name: String, signNumber: Int ) {
        self.starSign = starSign
        self.name = name
        self.signNumber = signNumber
    }
    
   
    
}
