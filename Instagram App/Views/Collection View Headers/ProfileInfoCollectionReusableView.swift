//
//  ProfileInfoCollectionReusableView.swift
//  Instagram App
//
//  Created by Dilan Pramodya on 2021-03-16.
//

import UIKit

class ProfileInfoCollectionReusableView: UICollectionReusableView {
        static let identifire = "ProfileInfoCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
