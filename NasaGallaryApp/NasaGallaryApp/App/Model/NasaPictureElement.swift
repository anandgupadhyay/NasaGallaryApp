//
//  NasaPictureElement.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 20/01/23.
//

import Foundation

struct NasaPictureElement: Codable {
    var copyright: String?
    var date, explanation: String
    var hdurl: String
    var mediaType: MediaType
    var serviceVersion: ServiceVersion
    var title: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}

enum MediaType: String, Codable {
    case image = "image"
}

enum ServiceVersion: String, Codable {
    case v1 = "v1"
}

typealias NasaPicture = [NasaPictureElement]
