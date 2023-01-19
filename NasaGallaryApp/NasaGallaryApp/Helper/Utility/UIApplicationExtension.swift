//
//  UIApplicationExtension.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 19/01/23.
//

import UIKit
import Foundation


extension UIApplication {
    
    static var appName: String {
            Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String ?? ProcessInfo.processInfo.processName
    }
    
    class func getTopViewController(base: UIViewController?) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

