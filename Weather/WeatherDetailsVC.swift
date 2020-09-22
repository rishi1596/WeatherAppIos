//
//  WeatherDetailsVC.swift
//  Weather
//
//  Created by Deltecs on 22/09/20.
//  Copyright © 2020 App. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class WeatherDetailsVC:UIViewController {
    var lat:String = ""
    var long:String = ""
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var details: UILabel!
    //    struct Response:Decodable {
//        var weather: [weather]
//        var main: [main]
//    }
//
//    struct weather: Decodable{
//        var main: String
//        var description: String
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        makeApiCall()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setTapGesture(){
            let gestRec = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            gestRec.numberOfTapsRequired = 1
            
            self.backButton.addGestureRecognizer(gestRec)
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer){
            self.dismiss(animated: true, completion: nil)
            print("called")
            

        }
    
    
    //completionHandler: @escaping (String)->void
    func makeApiCall(){
        
        //let finalURL = "http://api.openweathermap.org/data/2.5/weather?lat="
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+long+"&appid=f90fb01f412288b0825b30951b1fe291")!
        let callTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response,error) in
            do {
                let str = String(decoding: data!, as: UTF8.self)
//                let json = try JSONSerialization.data(withJSONObject: data!, options: JSONSerialization.WritingOptions.prettyPrinted)
//                let convert = String(data:json, encoding: String.Encoding.utf8)
                
     
                print(str)
                DispatchQueue.main.async {
                    self.details.text = str
                }
                
            } catch let error as Error {
                print("error")
            }
            
            
        })
        
        callTask.resume()
    }
    
    
    
    
}
