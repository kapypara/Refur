//
//  CustomTextField.swift
//  Refur
//
//  Created by Hasan Almadhoob on 26/03/2023.
//

import Foundation
import UIKit

class CustomTextField : UITextField {
    let padding: CGFloat = 45
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupLeftImageView(image : UIImage) {
        self.leftViewMode = .always
        let leftView = UIImageView(frame: CGRect(x: 10, y: self.frame.height / 2 - 10, width: 25, height: 18))
        leftView.tintColor = .brown
        leftView.image = image
        self.addSubview(leftView)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: self.padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: self.padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: self.padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
}
