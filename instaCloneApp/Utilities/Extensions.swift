//
//  Extensions.swift
//  instaCloneApp
//
//  Created by Şükrü Özkoca on 31.05.2022.
//

import Foundation
import UIKit


extension UIView {
    func round(cornerRadius:CGFloat , borderWidth:CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
        
    }
}

