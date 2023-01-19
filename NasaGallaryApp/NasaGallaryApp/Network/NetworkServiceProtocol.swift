//
//  NetworkServiceProtocol.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 19/01/23.
//

import Foundation

protocol NetworkServiceProtocol {
    func startNetworkTask(urlStr:String, params:[String:Any], resultHandler: @escaping (Result<Data?, Error>) -> Void)
}
