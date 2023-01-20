//
//  NasaPhotoCell.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit

class NasaPhotoCell: UICollectionViewCell {
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var imgPhoto: MyExtendedImage!
  @IBOutlet private weak var lblTitle: UILabel!
  @IBOutlet private weak var lblDate: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
      containerView.layer.cornerRadius = 6
      containerView.layer.masksToBounds = true
      containerView.configureDropShadow()
  }
  
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
