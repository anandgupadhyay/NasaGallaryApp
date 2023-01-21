//
//  NasaPhotoDataProvider.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 21/01/23.
//

import Foundation

class NasaPhotoDataProvider{
    static func loadJson(filename fileName: String) -> Data {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let dataObj = try Data(contentsOf: url)
                return dataObj
            } catch {
                print("error:\(error)")
            }
        }
        return Data()
    }
}
