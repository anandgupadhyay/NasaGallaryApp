//
//  NasaPhotoCell.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit

class NasaPhotoCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgPhoto: MyExtendedImage!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.isUserInteractionEnabled = true
        self.isUserInteractionEnabled = true
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
        containerView.configureDropShadow()
    }
    
//    override var isSelected: Bool{
//        didSet{
//            UIView.animate(withDuration: 2.0) {
//                self.transform = self.isSelected ? CGAffineTransform(scaleX: 0.9, y: 0.9) : CGAffineTransform.identity
//            }
//        }
//    }
    
    var photo: NasaPictureElement? {
        didSet {
            
            if let photo = photo {
                imgPhoto.loadImageWithUrl(URL(string: photo.url)!)
                lblTitle.text = photo.title
                lblDate.text = photo.date
            }
        }
    }
}
