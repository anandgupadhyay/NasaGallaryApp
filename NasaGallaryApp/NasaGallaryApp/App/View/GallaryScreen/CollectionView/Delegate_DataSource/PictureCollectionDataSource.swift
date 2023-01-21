//
//  PictureCollectionDataSource.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit


extension GallaryViewController: UICollectionViewDataSource {
    /// 1
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nasaPicVm.pictureListModel.value?.count ?? 0
    }
    
    /// 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NasaPhotoCell", for: indexPath as IndexPath) as! NasaPhotoCell
        if !cell.isAnimated {
            
            UIView.animate(withDuration: 0.5, delay: 0.5 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
                //options: indexPath.row % 2 == 0 ? .transitionFlipFromLeft : .transitionFlipFromRight
                //                            if indexPath.row % 2 == 0 {
                Animator.viewSlideInFromBottom(toTop: cell)
                //                            }
                //                            else {
                //                                Animator.viewSlideInFromRight(toLeft: cell)
                //                            }
            }, completion: { (done) in
                cell.isAnimated = true
            })
        }
        cell.photo = self.nasaPicVm.pictureListModel.value?[indexPath.row]
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
    //
    //        let celll = cell as! NasaPhotoCell
    //        if !celll.isAnimated{
    //        let column = Double(cell.frame.minX / cell.frame.width)
    //        let row = Double(cell.frame.minY / cell.frame.height)
    //        let distance = sqrt(pow(column, 2) + pow(row, 2))
    //        let delay = sqrt(distance) * 0.5
    //        cell.alpha = 1
    //        UIView.animate(withDuration: 0.5, delay: delay, options: [], animations: {
    //
    //            cell.transform = .identity
    //        }, completion: { bool in
    //            celll.isAnimated = true
    //        })
    //        }
    //    }
}
