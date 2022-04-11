//
//  HoroscopeDetail.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/11/22.
//

import Foundation

class HoroscopeDetail : HoroscopeUser {
    private struct Result: Codable {
        var sign : String
        var date: String
        var horoscope: String
}
    var sign = ""
    var date = ""
    var horoscope = ""
    
    
    
    func getData (completed: @escaping () -> ()) {
        print("lets see if the function is even getting called")
        let urlString = "https://ohmanda.com/api/horoscope/\(starSign)/"
        guard let url = URL(string: urlString) else {
            print("could not create URL")
             completed()
            return
        }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url)
            { (data, response, error) in
            if let error = error { print(error.localizedDescription )
            }
            do {
                //             let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.sign = result.sign
                self.date = result.date
                self.horoscope = result.horoscope
                
            } catch {
                debugPrint(error)
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
    
}
