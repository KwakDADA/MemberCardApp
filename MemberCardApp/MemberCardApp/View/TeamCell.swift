//
//  TeamCell.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

enum TeamCellConstants {
    static let content =
    """
    우리 마스터 2팀은 UIKit을 기반으로 한 iOS 앱 개발 역량을 향상하는 것을 목표로 합니다.
    
    실무에서 자주 사용하는 기술을 학습하고, 코드 리뷰와 프로젝트를 통해 깊이 있는 이해를 돕습니다.
    
    Auto Layout, Delegate Pattern, MVC 등의 핵심 개념을 익히며, 실전에서 바로 활용할 수 있는 경험을 쌓습니다.
    
    효율적인 개발 방식과 문제 해결 능력을 함께 연구하며 성장하는 팀입니다.
    """
}

final class TeamCell: UICollectionViewCell {
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = TeamCellConstants.content
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
            contentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
