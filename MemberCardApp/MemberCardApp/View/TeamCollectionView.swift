//
//  TeamCollectionView.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

enum MainSection: Hashable {
    case teamInfo
    case memberCard
}

enum MainItem: Hashable {
    case team
    case member(Member)
}

enum ReuseIdentifier {
    static let teamCell = "TeamCell"
    static let memberCell = "MemberCell"
}

final class TeamCollectionView: UIView {
    
    var sections: [MainSection]?

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: ReuseIdentifier.teamCell)
        collectionView.register(MemberCell.self, forCellWithReuseIdentifier: ReuseIdentifier.memberCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        collectionView.backgroundColor = .white
        setAddView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAddView() {
        addSubview(collectionView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self,
                  let sections = self.sections else { return nil }
            let section = sections[sectionIndex]
            
            switch section {
            case .teamInfo:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(100)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(100)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 36, leading: 0, bottom: 43, trailing: 0)
                
                return section
                
            case .memberCard:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(100)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.92),
                    heightDimension: .estimated(100)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 36, leading: 0, bottom: 43, trailing: 0)
                section.interGroupSpacing = 8
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            }
        }
        
        return layout
    }
}
