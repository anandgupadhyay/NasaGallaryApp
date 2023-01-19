//
//  AppObserver.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 19/01/23.
//

import Foundation

final class AppObserver<T> {
    typealias Listener = (T) -> Void
  
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T){
        self.value = value
    }

    func bind(listener: Listener?){
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
