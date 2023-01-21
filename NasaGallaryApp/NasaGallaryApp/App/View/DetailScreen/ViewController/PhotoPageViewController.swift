//
//  PhotoPageViewController.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation
import UIKit
class PhotoPageViewController: UIViewController {
    
    var selectedIndexPath: IndexPath?
    var nasaPicVm: NasaPictureVM?
    var photoPages:[PhotoPageView] = []
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        //support only portrait and rotate to portrait if not
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Support all orientation for rest of the VCs
        AppUtility.lockOrientation(.all)
    }
    
    func setupPages(){
        createPages()
        setupScrollView()
        pageControl.numberOfPages = photoPages.count
        view.bringSubviewToFront(pageControl)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let currentPage = self.selectedIndexPath?.row ?? 0 + 1
//            print("currentpage:\(currentPage)")
            self.pageControl.currentPage = currentPage
//            self.scrollView.scrollRectToVisible(CGRect(x: self.scrollView.center.x * CGFloat(currentPage), y: self.scrollView.center.y, width: self.scrollView.frame.width, height: self.scrollView.frame.height) ,animated: true)
        }
    }
    
    func createPages(){
        if let photos = self.nasaPicVm!.pictureListModel.value {
            for photo in photos{
                let nasaPhotoPage: PhotoPageView = Bundle.main.loadNibNamed("PhotoPageView", owner: self, options: nil)?.first as! PhotoPageView
                nasaPhotoPage.setupPage(photo: photo)
                photoPages.append(nasaPhotoPage)
            }
        }
    }
    
    func setupScrollView(){
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(photoPages.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< photoPages.count {
            photoPages[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(photoPages[i])
        }
    }
}

extension PhotoPageViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        //scale Image view
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            photoPages[0].imgPhoto.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            photoPages[1].imgPhoto.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            photoPages[1].imgPhoto.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            photoPages[2].imgPhoto.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            photoPages[2].imgPhoto.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            photoPages[3].imgPhoto.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            photoPages[3].imgPhoto.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            photoPages[4].imgPhoto.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
    }
    
    //    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
    //        if(pageControl.currentPage == 0) {
    //
    //            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
    //            pageControl.pageIndicatorTintColor = pageUnselectedColor
    //
    //
    //            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
    //            slides[pageControl.currentPage].backgroundColor = bgColor
    //
    //            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
    //            pageControl.currentPageIndicatorTintColor = pageSelectedColor
    //        }
    //    }
    //
    //    func fade(fromRed: CGFloat,
    //              fromGreen: CGFloat,
    //              fromBlue: CGFloat,
    //              fromAlpha: CGFloat,
    //              toRed: CGFloat,
    //              toGreen: CGFloat,
    //              toBlue: CGFloat,
    //              toAlpha: CGFloat,
    //              withPercentage percentage: CGFloat) -> UIColor {
    //
    //        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
    //        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
    //        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
    //        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
    //
    //        // return the fade colour
    //        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    //    }
    
}
