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
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .brown
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
            contentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
