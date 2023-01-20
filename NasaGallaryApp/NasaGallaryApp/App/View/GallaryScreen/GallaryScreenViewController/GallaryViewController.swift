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
        self.title = Bundle.main.appName
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        addRefreshButton()
        setUpCollectionView()
    }
    
    func onRefreshButtonClicked(_ sender: Any){
        print("SearchButtonClicked")
    }
    
    func loadNasaPictureData(){
        
        self.view.showLoading(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        nasaPicVm.fetchPhotos(params: [:]) { onComplete in
            let rowCount: Int =  self.nasaPicVm.pictureListModel.value?.count ?? 0
            if(rowCount == 0){
                self.openAlert(title: Bundle.main.appName, message: "No Pictures found", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default],actions: [
                    {_ in
                        
                    }
                ])
            }else{
                //Sort data
                self.sortPhotosBy(sortKey: "date")
            }
        }
        
        //bind observers
        nasaPicVm.pictureListModel.bind { [weak self] newModel in
            DispatchQueue.main.async {
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
            let firstCreatedAtDate = formatter.date(from: first.date)!
            let secondCreatedAtDate = formatter.date(from: second.date)!
            return firstCreatedAtDate >= secondCreatedAtDate
            
        }
        
    }
}

extension GallaryViewController{
    //Collection view related setup
    private func setUpCollectionView() {
        
        nasaPictureCollectionView.dataSource = self
        nasaPictureCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        nasaPictureCollectionView.setCollectionViewLayout(layout, animated: true)
        nasaPictureCollectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        nasaPictureCollectionView?.backgroundColor = .clear
    }
    
    public override func willTransition(to newCollection: UITraitCollection, with
                                        coordinator: UIViewControllerTransitionCoordinator) {
        //To update layour size while orientation
        if let layout = nasaPictureCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let itemSize = (nasaPictureCollectionView.frame.width - (nasaPictureCollectionView.contentInset.left + nasaPictureCollectionView.contentInset.right + 10)) / 2
            layout.itemSize = CGSize(width: itemSize, height: itemSize)
            layout.invalidateLayout()
        }
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
