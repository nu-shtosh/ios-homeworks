//
//  Extension + UIColor.swift
//  Navigation
//
//  Created by Илья Дубенский on 08.12.2022.
//

import UIKit

extension UIColor {
    func darker() -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0

        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        }

        return UIColor()
    }
}
