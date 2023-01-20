//
//  PictureUICollectionViewDelegateFlowLayout.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit

extension GallaryViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                  layout collectionViewLayout: UICollectionViewLayout,
//                  insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                   layout collectionViewLayout: UICollectionViewLayout,
//                   sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let lay = collectionViewLayout as! UICollectionViewFlowLayout
//
//        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
//        return CGSize(width: widthPerItem - 8, height: 250)
//    }
}
