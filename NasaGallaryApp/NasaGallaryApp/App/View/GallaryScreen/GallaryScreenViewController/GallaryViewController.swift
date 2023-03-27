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
    var nasaPicVm = NasaPictureVM()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupGallaryView()
        loadNasaPictureData()
//        loadNasaPictureDataFromLocal()
    }
    
    func setupGallaryView(){
        self.title = Bundle.main.appName
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        addRefreshButton()
        setUpCollectionView()
    }
    
    func loadNasaPictureDataFromLocal(){
        nasaPicVm.mockFetchPhotos(fileName: "NasaPhotos") { onComplete in
            let rowCount: Int =  self.nasaPicVm.pictureListModel.value?.count ?? 0
            if(rowCount == 0){
                self.openAlert(title: Bundle.main.appName, message: ErrorMessages.noPhotos, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default],actions: [
                    {_ in
                        self.nasaPictureCollectionView.isHidden = true
                        self.showNoDataView()
                    }
                ])
            }else{
                //Sort date
                self.loadPhotoData()
            }
        }
    }
    
    func loadPhotoData(){
        DispatchQueue.main.async {
        // UI Code Goes Here
        self.nasaPicVm.sortPhotosBy(sortKey: NasaPictureElement.CodingKeys.date.rawValue)
        self.nasaPictureCollectionView.isHidden = false
        self.hideNoDataView()
        }
    }
    
    func loadNasaPictureData(){
        self.view.showLoading(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        nasaPicVm.fetchPhotos(params: [:]) { onComplete in
            let rowCount: Int =  self.nasaPicVm.pictureListModel.value?.count ?? 0
            if(rowCount == 0){
                self.openAlert(title: Bundle.main.appName, message: ErrorMessages.noPhotos, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default],actions: [
                    {_ in
                        self.nasaPictureCollectionView.isHidden = true
                        self.showNoDataView()
                    }
                ])
            }else{
                self.loadPhotoData()
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
                self?.view.hideLoading()
            }
        }
    }
    
    
    //No Data View
    private lazy var nodataView: NoDataView = {
//        let nodataView = NoDataView(frame: CGRect(x: 0,y: 0,width: NodataViewSize,height: NodataViewSize))
        let ndV: NoDataView = Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)?.first as! NoDataView
        ndV.center = view.center
        ndV.setupNoDataView()
        return ndV
    }()
    
    func showNoDataView() {
        view.addSubview(nodataView)
        view.bringSubviewToFront(nodataView)
    }

    func hideNoDataView() {
        nodataView.removeFromSuperview()
    }
    
}

// MARK: - CollectionView
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

// MARK: - Refresh Button
extension GallaryViewController{
    
    func addRefreshButton(){
        let refreshAction = UIAction(handler: { [weak self] _ in
            //perform action here
            self?.loadNasaPictureData()
        })
        let refreshBarButtonItem = UIBarButtonItem(systemItem: .refresh, primaryAction: refreshAction, menu: nil)
        refreshBarButtonItem.accessibilityIdentifier = CONST_Refresh
        self.navigationItem.rightBarButtonItem  = refreshBarButtonItem
    }
    
}
