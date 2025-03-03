//
//  TeamCell.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class TeamCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
