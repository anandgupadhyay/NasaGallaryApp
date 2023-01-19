//
//  NewtorkHelper.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 19/01/23.
//

import Foundation


class NetworkHelper: NetworkServiceProtocol {
    static let shared = NetworkHelper()
    
    func startNetworkTask(urlStr:String, params:[String:Any], resultHandler: @escaping (Result<Data?, Error>) -> Void)  {
        
        guard let urlObject = URL(string:urlStr) else {
            let errorTemp = NetworkError(title: "url error", description: "", code: 500)
            //print("issue in url object")
            resultHandler(.failure(errorTemp))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: urlObject)) { dataObject, responseObj, errorObject in
            
            if let error = errorObject {
                resultHandler(.failure(error))
            } else {
                resultHandler(.success(dataObject))
            }
        }.resume()
    }
}
