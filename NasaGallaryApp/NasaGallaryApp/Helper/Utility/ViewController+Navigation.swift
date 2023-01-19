//
//  ViewController+Navigation.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 19/01/23.
//

import UIKit

extension UIViewController {
    
    // Push view controller
    func pushVC(destinationVC:UIViewController) {
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    // Pop view controller
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Pop to root view controller
    func popToRootVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //Pop view controller with source vc
    func popWithVC(sourceVC:UIViewController) {
        self.navigationController?.popToViewController(sourceVC, animated: true)
    }
    
    // Global Alert
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}
