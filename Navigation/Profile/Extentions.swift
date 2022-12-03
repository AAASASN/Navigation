//
//  Extentions.swift
//  Navigation
//
//  Created by Александр Мараенко on 03.12.2022.
//

import Foundation
import UIKit


extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
