//
//  TeamCell.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class TeamCell: UICollectionViewCell {
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "예시\n1. ~~~~ \n2. ~~~~~\n3. ~~~~~~~~"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAddView() {
        addSubview(contentLabel)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
