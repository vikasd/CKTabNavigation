//
//  UIColor+CKExtension.swift
//  CKTabNavigation
//
//  Created by Vikas Dalvi  on 13/09/19.
//  Copyright © 2019 Vikas Dalvi . All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init?(hex: String) {
        
        guard hex.count > 6 else { return nil }
        
        if hex.hasPrefix("#") {
            
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    
                    let red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    let green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    let blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    let alpha = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
                
            } else if hexColor.count == 6 {
                
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    
                    let red = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    let green = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    let blue = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: red, green: green, blue: blue, alpha: 1.0)
                    return
                }
            }
        }
        
        return nil
    }
}
