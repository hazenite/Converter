//
//  ViewController.swift
//  Converter
//
//  Created by Magdalena Kajszczak on 14/01/2022.
//

import UIKit
struct Price: Codable {
    let EUR_USD: Double
    
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var InputValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func converterButton(_ sender: UIButton) {
        let apiKey = "YOUR API KEY"
        let currency = Double(self.InputValue.text!)!
        let url = URL(string: "https://free.currconv.com/api/v7/convert?q=EUR_usd&compact=ultra&apiKey="+apiKey)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data {
                do {
                    let rest = try JSONDecoder().decode(Price.self, from: data)
                    print(rest.EUR_USD * currency)
                }
                catch {
                    return
                }
            }
            
            
        }
        
        task.resume()
    }
    
    
}

