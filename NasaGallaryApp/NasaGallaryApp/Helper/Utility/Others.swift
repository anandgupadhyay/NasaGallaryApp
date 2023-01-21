//
//  Others.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 19/01/23.
//

import Foundation
import UIKit

/// Extension for random value get.
extension CGFloat {
    static func randomValue() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}


/// Extension for random color using random value.
extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(
           red:   .randomValue(),
           green: .randomValue(),
           blue:  .randomValue(),
           alpha: 1.0
        )
    }
}

extension Bundle {
    var appName: String {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
        object(forInfoDictionaryKey: "CFBundleName") as? String ??
        ""
    }
}

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
   
        self.lockOrientation(orientation)
    
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}
