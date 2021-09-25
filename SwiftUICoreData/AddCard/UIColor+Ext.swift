//
//  UIColor+Ext.swift
//  SwiftUICoreData
//
//  Created by Will Wang on 9/24/21.
//

import UIKit

extension UIColor {
    class func color(data:Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }
    
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}
