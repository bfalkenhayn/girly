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
    var user: [HoroscopeUser] = []
    
    init(starSign: String, name: String ) {
        self.starSign = starSign
        self.name = name
    }
    
    
    func loadData(completed: @escaping () -> ()) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            user = try jsonDecoder.decode([HoroscopeUser].self, from: data)
           }
        catch {print("error in loading data")
    }
        print("load data")
        completed()
        
        
}
      func saveData() {
          print("save data functions")
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
          let data = try? jsonEncoder.encode(user)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {print("error: could not save data")}
    
    }
    
    
    
   
    
}
