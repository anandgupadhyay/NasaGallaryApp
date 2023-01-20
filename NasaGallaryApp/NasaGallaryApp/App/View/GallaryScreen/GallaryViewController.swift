//
//  GallaryViewController.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit

class GallaryViewController: UIViewController {

    @IBOutlet weak var pictureCollectionView: UICollectionView!

    private var nasaPicVm = NasaPictureVM()//Instantiate View Model
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
            let rowCount: Int = self.nasaPicVm.pictureListModel.value?.count ?? 0
            print(self.nasaPicVm.pictureListModel.value!)
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
                self?.pictureCollectionView.reloadData()
                self?.view.hideLoading()
//                self?.tblMovieList.reloadData()
//                self?.tblMovieList.stopLoading()//stop load more indicator
            }
        }
        
        nasaPicVm.isToShowLoader.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.pictureCollectionView.reloadData()
                self?.view.hideLoading()
//                self?.view.hideLoading()
            }
        }
        
        
    }
}


extension GallaryViewController{
    private func setUpCollectionView() {
         /// 1
        pictureCollectionView.register(UICollectionViewCell.self,
                 forCellWithReuseIdentifier: "cell")
        
         /// 2
        pictureCollectionView.delegate = self
        pictureCollectionView.dataSource = self

         /// 3
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         /// 4
         layout.minimumLineSpacing = 8
         /// 5
         layout.minimumInteritemSpacing = 4

         /// 6
        pictureCollectionView.setCollectionViewLayout(layout, animated: true)
       }
}

extension GallaryViewController{
    
    func addRefreshButton(){
    //add Refresh button with Action
//    if #available(iOS 14.0, *){
            let refreshAction = UIAction(handler: { [weak self] _ in
               //perform action here
                self?.loadNasaPictureData()
            })
            let refreshBarButtonItem = UIBarButtonItem(systemItem: .refresh, primaryAction: refreshAction, menu: nil)
            self.navigationItem.rightBarButtonItem  = refreshBarButtonItem
        
//    }else{
//        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"), style: .plain, target: self, action: #selector(onSearchButtonClicked))
//        self.navigationItem.rightBarButtonItem  = searchBarButtonItem
//    }
    }
    
    @objc func onSearchButtonClicked(_ sender: Any){
        print("SearchButtonClicked")
    }
}
