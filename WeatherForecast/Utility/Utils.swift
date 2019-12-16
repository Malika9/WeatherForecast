//
//  Utils.swift
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func prepareDisplayModel(dataModel: WeatherDataModel) {
        var displayModel = WeatherDisplayModel()
        var min_temp: Double = Double(Int.max)
        var max_temp: Double = Double(Int.min)
        let currentTime = Date().currentTimeMillis()
        guard let listArr = dataModel.list else {return}
        var isSlotFound = false
        for i in 0..<8 {
            let slotData = listArr[i]
            guard let slotMinTemp = slotData.main?.temp_min, let slotMaxTemp = slotData.main?.temp_max, let slotStartTime = slotData.dt else {return}
            if min_temp > slotMinTemp{
                min_temp = slotMinTemp
            }
            if max_temp < slotMaxTemp {
                max_temp = slotMaxTemp
            }

            if currentTime >= slotStartTime {
                displayModel.temp = slotData.main?.temp ?? 0
                displayModel.humidity = slotData.main?.humidity ?? 0
                displayModel.speed = slotData.wind?.speed ?? 0
                let weather = slotData.weather?[0]
                displayModel.weather = weather?.main ?? ""
                isSlotFound = true
                break
            }
        }
        displayModel.heading = dataModel.city?.name
        displayModel.min_temp = min_temp
        displayModel.max_temp = max_temp
        if !isSlotFound {
            displayModel.temp = listArr[7].main?.temp ?? 0
            displayModel.humidity = listArr[7].main?.humidity ?? 0
            displayModel.speed = listArr[7].wind?.speed ?? 0
            let weather = listArr[7].weather?[0]
            displayModel.weather = weather?.main ?? ""
        }
        DataManager.weatherDisplayArr.append(displayModel)
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -3, height: 3)
        self.layer.shadowRadius = 3
    }
}

extension Date {
    func currentTimeMillis() -> Int {
        return Int(self.timeIntervalSince1970)
    }
}
