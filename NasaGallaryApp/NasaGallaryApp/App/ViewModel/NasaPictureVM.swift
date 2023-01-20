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
    
    internal func fetchPhotos(params:[String:Any], complete: @escaping (AppObserver<NasaPicture?>)->()) {
            isToShowLoader.value = true
            
        self.apiService.startNetworkTask(urlStr: NetworkHelperConstants.movieListURL, params: [:]) { result in
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
