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
//        cell.alpha = 0
//        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        cell.photo = self.nasaPicVm.pictureListModel.value?[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
//        let column = Double(cell.frame.minX / cell.frame.width)
//        let row = Double(cell.frame.minY / cell.frame.height)
//        let distance = sqrt(pow(column, 2) + pow(row, 2))
//        let delay = sqrt(distance) * 0.5
//        cell.alpha = 1
//        UIView.animate(withDuration: 0.5, delay: delay, options: [], animations: {
//            cell.transform = .identity
//        })
//    }
}
