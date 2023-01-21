//
//  NasaPictureVM.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation

class NasaPictureVM {
    
    private let apiService: NetworkServiceProtocol
    init(apiService: NetworkServiceProtocol = NetworkHelper()) {
        self.apiService = apiService
    }
    
    //create observers
    internal var isToShowLoader: AppObserver<Bool> = AppObserver(false)
    internal let pictureListModel: AppObserver<NasaPicture?> = AppObserver(nil)
    
    internal func mockFetchPhotos(fileName: String, complete: @escaping (AppObserver<NasaPicture?>)->()){
        let jsonData = NasaPhotoDataProvider.loadJson(filename: fileName)
        let decoderObject = JSONDecoder()

        do {
            self.pictureListModel.value = try decoderObject.decode(NasaPicture.self, from: jsonData)
        }catch{
            
        }
        complete(self.pictureListModel)
        
    }
    
    internal func fetchPhotos(params:[String:Any], complete: @escaping (AppObserver<NasaPicture?>)->()) {
        isToShowLoader.value = true
        
        self.apiService.startNetworkTask(urlStr: NetworkHelperConstants.photoListURL, params: [:]) { result in
            self.isToShowLoader.value = false
            switch result {
            case .success(let dataObject):
                do {
                    let decoderObject = JSONDecoder()
                    if self.pictureListModel.value == nil {
                        self.pictureListModel.value = try decoderObject.decode(NasaPicture.self, from: dataObject!)
                    }
                }
                catch {
                    //
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            complete(self.pictureListModel)
        }
    }
}

extension NasaPictureVM{
    
    func sortPhotosBy(sortKey: String){
        if (self.pictureListModel.value?.count ?? 0) > 0 {
            
            if sortKey == NasaPictureElement.CodingKeys.date.rawValue{
                let formatter = DateFormatter()
                formatter.dateFormat = CONST_Date_Format
                self.pictureListModel.value = self.pictureListModel.value?.sorted { first, second -> Bool in
                let firstCreatedAtDate = formatter.date(from: first.date)!
                let secondCreatedAtDate = formatter.date(from: second.date)!
                return firstCreatedAtDate >= secondCreatedAtDate
                }
            }
        }
    }
    
}
