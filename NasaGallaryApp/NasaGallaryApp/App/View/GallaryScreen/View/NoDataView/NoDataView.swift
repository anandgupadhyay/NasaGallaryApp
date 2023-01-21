//
//  NoDataView.swift
//  NasaGallaryApp
//
//  Created by Anand Upadhyay on 21/01/23.
//

import Foundation
import UIKit

class NoDataView: UIView {
    // MARK: - IBOutlet
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var lblNoData: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
//        loadFromNib()
//        addSubview(contentView)
//        lblNoData.text = ErrorMessages.noPhotos
    }
    
    func setupNoDataView()
    {
        addSubview(contentView)
        lblNoData.text = ErrorMessages.noPhotos
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonInit()
    }

    private func commonInit() {
        loadFromNib()
        lblNoData.text = ErrorMessages.noPhotos
        addSubview(contentView)
    }
}
