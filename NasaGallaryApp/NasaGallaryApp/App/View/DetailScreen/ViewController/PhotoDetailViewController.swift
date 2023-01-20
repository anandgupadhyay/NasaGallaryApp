//
//  PhotoDetailViewController.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit

class PhotoDetailViewController: UIViewController {
    
    var selectedIndexPath: IndexPath?
    var nasaPicVm: NasaPictureVM?
    
    @IBOutlet weak var internatViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtExplanation: UITextView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPhoto: MyExtendedImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(self.nasaPicVm!.pictureListModel.value![0])
        setupData()
    }
    
    func setupData(){

        if let idxPath = selectedIndexPath {
        let nasaPhoto = self.nasaPicVm!.pictureListModel.value![idxPath.row]
        self.title =  nasaPhoto.title
        self.lblTitle.text = nasaPhoto.title
        if let strCopyright = nasaPhoto.copyright{
            self.lblDate.text = "© \(strCopyright)"
        }else{
            self.lblDate.text = ""
        }
        self.txtExplanation.text = nasaPhoto.explanation
            loadImage(hdUrl: nasaPhoto.url)
        }
    }
    
    func loadImage(hdUrl: String){
        guard let hdImgUrl = URL(string: hdUrl) else {return}
        self.imgPhoto.loadImageWithUrl(hdImgUrl)
    }
}

