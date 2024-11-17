//
//  UIFont_Extension.swift
//  EventHubApp
//
//  Created by Дмитрий Волков on 17.11.2024.
//

import UIKit

extension UIFont {
    
    enum AirbnbFont: String {
        case semibold = "AirbnbCereal_W_Bd"
        case normal = "AirbnbCereal_W_Bk"
        case bold = "AirbnbCereal_W_Blk"
        case light = "AirbnbCereal_W_Lt"
        case extrabold = "AirbnbCereal_W_Xbd"
        case medium = "AirbnbCereal_W_Md"
    }
    
    class func airbnbFont(ofSize fontSize: CGFloat, weight: AirbnbFont) -> UIFont {
        return UIFont(name: weight.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}
