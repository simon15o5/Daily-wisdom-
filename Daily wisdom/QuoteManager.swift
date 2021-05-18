//
//  QuoteManager.swift
//  Daily wisdom
//
//  Created by Simon Alam on 30.04.21.
//

import Foundation
protocol QuoteManagerDelegate {
    func updateUI(_ data: Quote)
    var currentQuote: String { get set }
    
}
class QuoteManager {
    var api = "https://api.kanye.rest"
    
    var delegate: QuoteManagerDelegate?
    func fetchData()  {
        if let url = URL(string: api) {
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error")
                }
                
                if let safeData = data {
                    if let quote = self.parseJSON(safeData) {
                        self.delegate?.updateUI(quote)
                        self.delegate?.currentQuote = quote.quote
                        
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ data: Data) -> Quote? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Quote.self, from: data)
            return decodedData
            
           
           
            
            
            
            
        } catch {
           
return nil
            
        }
    }
    
}
