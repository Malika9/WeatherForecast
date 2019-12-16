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
