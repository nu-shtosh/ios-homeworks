//
//  Exetention + UIVIew.swift
//  Navigation
//
//  Created by Илья Дубенский on 07.12.2022.
//

import UIKit

extension UIView {
    func addSubviewsIn(_ view: UIView, _ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addSubview(subview)
        }
    }
}

