//
//  MainViewController.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<MainSection, MainItem>
    
    private lazy var teamCollectionView: TeamCollectionView = .init()
    private var dataSource: DataSourceType?
    private var sections = [MainSection]()
    
    override func loadView() {
        view = teamCollectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
    }
}

// MARK: - DiffableDataSource
extension MainViewController {
    private func configureDataSource() {
        dataSource = .init(collectionView: teamCollectionView.collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            
            let sections = self.sections[indexPath.section]
            
            switch sections {
            case .teamInfo:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.teamCell, for: indexPath) as! TeamCell
                
                return cell
            case .memberCard:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.memberCell, for: indexPath) as! MemberCell
                
                // cell.configureCell()
                
                return cell
            }
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<MainSection, MainItem>()
        initialSnapshot.appendSections([.teamInfo, .memberCard])
        
        sections = initialSnapshot.sectionIdentifiers
        teamCollectionView.sections = sections
        dataSource?.apply(initialSnapshot, animatingDifferences: true)
    }
}
