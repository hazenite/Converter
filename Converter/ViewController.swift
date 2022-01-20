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
    
    
    @IBOutlet weak var inputValue: UITextField!
    @IBOutlet weak var outputValue: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func converterButton(_ sender: UIButton) {
        
        let apiKey = "YOUR API KEY"
       
        let url = URL(string: "https://free.currconv.com/api/v7/convert?q=EUR_usd&compact=ultra&apiKey="+apiKey)!
        
        let alert = UIAlertController(title: "Błąd", message: "Wartość nie może być pusta!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        guard let currency = Double((self.inputValue.text!)) else  {
            return self.present(alert, animated: true, completion: nil)
        }
       
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data {
                do {
                    let jsonDecode = try JSONDecoder().decode(Price.self, from: data)
                    let saveValue = jsonDecode.EUR_USD * currency
                    let convertToString = String(saveValue)
                    
                    DispatchQueue.main.async {
                        self.outputValue.text = "Kwota w USD: " + convertToString
                    }
                    
                }
                catch {
                    return
                }
            }
            
            
        }
        
        task.resume()
    }
    
    
}

