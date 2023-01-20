//
//  PhotoPageView.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit

class PhotoPageView: UIView {

    @IBOutlet weak var imgPhoto: MyExtendedImage!
    @IBOutlet weak var txtTitle: UITextView!
    @IBOutlet weak var txtExplaination: UITextView!
    
    func setupPage(photo: NasaPictureElement){
        if let imgUrl = URL(string: photo.url){
            imgPhoto.loadImageWithUrl(imgUrl)
        }
        txtExplaination.text = photo.explanation
        txtExplaination.sizeToFit()
        txtTitle.text = photo.title
        if let strCopyRight = photo.copyright{
            txtTitle.text = txtTitle.text + "\n ©  \(strCopyRight)"
        }
        
    }
}
