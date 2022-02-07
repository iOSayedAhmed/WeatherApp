//
//  EditCityVC.swift
//  WeatherApp
//
//  Created by Develop on 2/7/22.
//  Copyright © 2022 Develop. All rights reserved.
//

import UIKit
var selectedCityID:City?
var CityArray = [
    City(name: "Alexandria", id: "361058"),
    City(name: "Al Ibrāhīmīyah", id: "361103"),
    City(name: "Al Ḩawāmidīyah", id: "361179"),
    City(name: "Hurghada", id: "361291"),
    City(name: "al Gharbīyah", id: "361294"),
    City(name: "Al Fayyūm", id: "361320"),
    City(name: "Beheira", id: "361370"),
    City(name: "Red Sea", id: "361468"),
    City(name: "Arish", id: "361546"),
    City(name: "Al ‘Alamayn", id: "361612"),
    City(name: "Muḩāfaz̧at ad Daqahlīyah", id: "361849"),
    City(name: "Abu Simbel", id: "362041"),
    City(name: "Marsa Alam", id: "352736"),
    City(name: "Kafr Shukr", id: "354076"),
    City(name: "Kafr ad Dawwār", id: "354775"),
    City(name: "Kafr ash Shaykh", id: "354500"),
]


class EditCityVC: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        if let city = selectedCityID {
            NotificationCenter.default.post(name: NSNotification.Name.init("cityValueEdited"), object: nil, userInfo:["city":city])
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
extension EditCityVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CityArray[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.cityNameLabel.text = CityArray[row].name
        selectedCityID = CityArray[row]
       
        
        
    }
    
}
