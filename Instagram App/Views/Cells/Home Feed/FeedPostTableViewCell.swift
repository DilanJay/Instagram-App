//
//  FeedPostTableViewCell.swift
//  Instagram App
//
//  Created by Dilan Pramodya on 2021-03-14.
//

import UIKit

final class FeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "FeedPostTableViewCell.swift"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        //Confirure the cells
    }
}
