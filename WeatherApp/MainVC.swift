//
//  ViewController.swift
//  WeatherApp
//
//  Created by Develop on 2/6/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD
var cityId = "360630"


var weatherArray : [Weather] = []

class MainVC: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var prussereLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.dismiss()
        NotificationCenter.default.addObserver(self, selector: #selector(cityEdited), name: NSNotification.Name.init("cityValueEdited"), object: nil)
      
       getCityWeatherInfo()
  
        
    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {

        let vc = storyboard?.instantiateViewController(identifier: "EditCityVC") as! EditCityVC
        self.present(vc, animated: true)

        
    }
    @objc func cityEdited(notification:Notification){
        if let city = notification.userInfo?["city"] as? City {
            self.cityNameLabel.text = city.name
            cityId = city.id
            getCityWeatherInfo()
        }
        
    }
    
    func getCityWeatherInfo(){
        let params = ["id" : cityId, "appid": "495375859304beffd9af4c94d66e02fc"]
        
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: params).responseDecodable(of:Weather.self) {response  in
            
            //print(response.value)
            guard let result = response.value else {return}
            weatherArray = [result]
            guard var temp = weatherArray[0].main.temp as? Double else {return}
            guard let humidity = weatherArray[0].main.humidity as? Int else {return}
            guard let pressure = weatherArray[0].main.pressure as? Int else {return}
            temp = temp - 272.15
            temp = Double(round(1000 * temp) / 1000 )
            ProgressHUD.animationType = .circleRotateChase
            ProgressHUD.showProgress(1)
            let _ = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
                self.tempLabel.text = "\(temp) , °C"
                self.prussereLabel.text = "\(pressure)"
                self.humidityLabel.text = "\(humidity)"
                ProgressHUD.dismiss()
            }
            
            
            
        }
    }

}
