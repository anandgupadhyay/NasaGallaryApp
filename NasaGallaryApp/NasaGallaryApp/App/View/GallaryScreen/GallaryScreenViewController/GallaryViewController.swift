//
//  GallaryViewController.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit

class GallaryViewController: UIViewController {

    @IBOutlet weak var nasaPictureCollectionView: UICollectionView!

    var nasaPicVm = NasaPictureVM()//Instantiate View Model
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       setupGallaryView()
       loadNasaPictureData()
    }

    func setupGallaryView(){
        self.title = "Nasa Apod Gallary"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        addRefreshButton()
        setUpCollectionView()
    }
    
    func onRefreshButtonClicked(_ sender: Any){
        print("SearchButtonClicked")
    }
    
    func loadNasaPictureData(){
        
        self.view.showLoading(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        nasaPicVm.fetchMovieList(params: [:]) { onComplete in
            let rowCount: Int =  self.nasaPicVm.pictureListModel.value?.count ?? 0
//            print(self.nasaPicVm.pictureListModel.value!)
            if(rowCount == 0){
                self.openAlert(title: UIApplication.appName, message: "No Pictures found", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default],actions: [
                    {_ in
                        
                    }
                ])
            }
        }
        
        //bind observers
        nasaPicVm.pictureListModel.bind { [weak self] newModel in
            DispatchQueue.main.async {
                
                self?.sortPhotosBy(sortKey: "date")
                self?.nasaPictureCollectionView.reloadData()
                self?.view.hideLoading()
            }
        }
        
        nasaPicVm.isToShowLoader.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.nasaPictureCollectionView.reloadData()
                self?.view.hideLoading()
//                self?.view.hideLoading()
            }
        }
    }
    
    func sortPhotosBy(sortKey: String){
        
        let formatter = DateFormatter()
        formatter.dateFormat = CONST_Date_Format
        
        self.nasaPicVm.pictureListModel.value = self.nasaPicVm.pictureListModel.value?.sorted { first, second -> Bool in
            guard let firstCreatedAt = first.date as? String,
                  let firstCreatedAtDate = formatter.date(from: firstCreatedAt),
                  let secondCreatedAt = second.date as? String,
                  let secondCreatedAtDate = formatter.date(from: secondCreatedAt) else {
                return false
            }
            return firstCreatedAtDate > secondCreatedAtDate
        }
        
    }
}


extension GallaryViewController{
    private func setUpCollectionView() {
        
        nasaPictureCollectionView.delegate = self
        nasaPictureCollectionView.dataSource = self
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.minimumLineSpacing = 8
         layout.minimumInteritemSpacing = 4
        nasaPictureCollectionView.setCollectionViewLayout(layout, animated: true)
        nasaPictureCollectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        nasaPictureCollectionView?.backgroundColor = .clear
    }
}

extension GallaryViewController{
    
    func addRefreshButton(){
            let refreshAction = UIAction(handler: { [weak self] _ in
               //perform action here
                self?.loadNasaPictureData()
            })
            let refreshBarButtonItem = UIBarButtonItem(systemItem: .refresh, primaryAction: refreshAction, menu: nil)
            self.navigationItem.rightBarButtonItem  = refreshBarButtonItem
    }
}
