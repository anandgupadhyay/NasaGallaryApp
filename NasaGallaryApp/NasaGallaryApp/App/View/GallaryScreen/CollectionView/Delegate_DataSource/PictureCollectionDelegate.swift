//
//  PictureCollectionDelegate.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit

extension GallaryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController {
            detailVC.selectedIndexPath = indexPath
            detailVC.nasaPicVm = self.nasaPicVm
            self.pushVC(destinationVC: detailVC)
        }
    }

}
