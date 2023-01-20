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
        cell.photo = self.nasaPicVm.pictureListModel.value?[indexPath.row]
        return cell
    }
}
