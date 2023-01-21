//
//  UIView+Loading.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 19/01/23.
//

import UIKit

extension UIView{
    
    func showLoading(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = CONST_LoadingIndicator_Tag
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)

        self.addSubview(backgroundView)
    }

    func hideLoading() {
        if let background = viewWithTag(CONST_LoadingIndicator_Tag){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}

//NSShadow
extension UIView{
    
    open func configureDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = true
    }

    /// A convenience function to turn off drop shadow
    open func configureNoDropShadow() {
        layer.shadowOpacity = 0
    }
    
    @discardableResult
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).nameOfClass
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first
            as? UIView ?? UIView()
    }
}


