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
        view.backgroundColor = .white
        
        configureDataSource()
    }
}

// MARK: - DiffableDataSource
extension MainViewController {
    private func configureDataSource() {
        dataSource = .init(collectionView: teamCollectionView.collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            let sections = self.sections[indexPath.section]
            
            switch sections {
            case .teamInfo:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.teamCell, for: indexPath) as! TeamCell
                
                return cell
            case .memberCard:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.memberCell, for: indexPath) as! MemberCell
                
                guard let member = item.member else { return cell }
                cell.configureCell(withMember: member)
                
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case SupplementaryViewKind.header:
                let section = self.sections[indexPath.section]
                let sectionTitle: String
                
                switch section {
                case .teamInfo:
                    sectionTitle = MainHeaderTitle.team
                case .memberCard:
                    sectionTitle = MainHeaderTitle.member
                }
                
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: SupplementaryViewKind.header,
                    withReuseIdentifier: ReuseIdentifier.mainHeaderView,
                    for: indexPath) as! MainHeaderView
                headerView.configureHeader(withTitle: sectionTitle)
                
                return headerView
                
            default:
                return nil
            }
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<MainSection, MainItem>()
        initialSnapshot.appendSections([.teamInfo, .memberCard])
        
        // TODO: 레이아웃 확인용, 데이터 연동 후 삭제
        initialSnapshot.appendItems([.team], toSection: .teamInfo)
        initialSnapshot.appendItems([.member(Member(id: UUID(), name: "이름", imageURL: "", content: "내용!!")),
                                     .member(Member(id: UUID(), name: "이름", imageURL: "", content: "내용!!")),
                                     .member(Member(id: UUID(), name: "이름", imageURL: "", content: "내용!!"))], toSection: .memberCard)
        
        sections = initialSnapshot.sectionIdentifiers
        teamCollectionView.sections = sections
        dataSource?.apply(initialSnapshot, animatingDifferences: true)
    }
}
