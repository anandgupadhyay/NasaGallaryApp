//
//  NetworkErrorProtocol.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 19/01/23.
//

import Foundation


protocol NasaPictureErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

struct NetworkError: NasaPictureErrorProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
