//
//  UIFont+Extension.swift
//  Pomodoro
//
//  Created by Ali Amanvermez on 11.08.2023.
//

import Foundation
import UIKit
extension UIFont {
    static func remRegular(size : CGFloat)->UIFont?{
        return UIFont(name : "REM-Regular", size : size)
    }
    static func remThin(size : CGFloat)->UIFont?{
        return UIFont(name : "REM-Thin", size : size)
    }
    static func remThinItalic(size : CGFloat)->UIFont?{
        return UIFont(name : "REM-ThinItalic", size : size)
    }
    static func remLight(size : CGFloat)->UIFont?{
        return UIFont(name : "REM-Light", size : size)
    }
    static func remMedium(size : CGFloat)->UIFont?{
        return UIFont(name : "REM-Medium", size : size)
    }
    static func remSemiBold(size : CGFloat)->UIFont?{
        return UIFont(name : "REM-SemiBold", size : size)
    }
    static func remBold(size : CGFloat)->UIFont?{
        return UIFont(name : "REM-Bold", size : size)
    }
    static func remExtraBold(size : CGFloat)->UIFont?{
        return UIFont(name : "REM-ExtraBold", size : size)
    }
    static func remBlack(size : CGFloat)->UIFont?{
        return UIFont(name : "REM-Black", size : size)
    }
}
