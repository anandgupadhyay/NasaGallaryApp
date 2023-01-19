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
