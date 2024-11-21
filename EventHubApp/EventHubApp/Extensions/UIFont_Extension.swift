//
//  UIFont_Extension.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 17.11.2024.
//

import UIKit

extension UIFont {
    
    enum AirbnbFont: String {
        case bold = "AirbnbCerealWBd"
        case book = "AirbnbCerealWBk"
        case black = "AirbnbCerealWBlk"
        case light = "AirbnbCerealWLt"
        case extrabold = "AirbnbCerealWXBd"
        case medium = "AirbnbCerealWMd"
    }
    
    class func airbnbFont(ofSize fontSize: CGFloat, weight: AirbnbFont) -> UIFont {
        return UIFont(name: weight.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}
