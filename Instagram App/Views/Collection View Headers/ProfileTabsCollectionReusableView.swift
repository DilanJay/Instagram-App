//
//  ProfileTabsCollectionReusableView.swift
//  Instagram App
//
//  Created by Dilan Pramodya on 2021-03-16.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifire = "ProfileTabsCollectionReusableView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
