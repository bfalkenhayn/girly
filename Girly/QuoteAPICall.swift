//
//  QuoteAPICall.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/29/22.
//

import Foundation

class QuoteAPICall {
    
    
     struct Result: Codable {
         var content: String
         var author: String
     
}
    

    var content = ""
    var author = ""
    
    
    
    func getData (completed: @escaping () -> ()) {
   
        let urlString = "https://api.quotable.io/random?maxLength=50"
        guard let url = URL(string: urlString) else {
            print("QUOTE API: could not create URL")
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
                guard data! != nil else {
                    completed()
                    return
                }
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.author = result.author
                self.content = result.content
                
            
            
                
            } catch {
                debugPrint(error)
                print("JSON ERROR for QUOTE API: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
    
}


