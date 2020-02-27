//
//  GradientView.swift
//  Project37
//
//  Created by Mohammed Hamdi on 10/6/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {

    @IBInspectable var topColor: UIColor = UIColor.white
    @IBInspectable var bottomColor: UIColor = UIColor.black

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
    }
}
