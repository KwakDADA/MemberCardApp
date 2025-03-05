//
//  MainViewController.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    //test
    private var viewModel = MemberViewModel.shared
    private lazy var teamCollectionView: TeamCollectionView = .init()
    private var dataSource: UICollectionViewDiffableDataSource<MainSection, MainItem>?
    private var sections = [MainSection]()
    
    override func loadView() {
        view = teamCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        teamCollectionView.collectionView.delegate = self
        configureDataSource()
        bindViewModel()
        viewModel.fetchMembers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchMembers()
    }
    
    private func bindViewModel() {
        viewModel.onMembersUpdated = { [weak self] members in
            DispatchQueue.main.async {
                self?.updateSnapshot(with: members)
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath),
              case let .member(member) = item else { return }
        
        if indexPath.row == viewModel.members.count {
            self.navigationController?.pushViewController(AddEditViewController(member: member),animated: true)
        } else {
            self.navigationController?.pushViewController(DetailViewController(member: member),animated: true)
        }
    }
}

// MARK: - DiffableDataSource
extension MainViewController {
    private func configureDataSource() {
        dataSource = .init(collectionView: teamCollectionView.collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let self = self else { return nil }
            let sections = self.sections[indexPath.section]
            
            switch sections {
            case .teamInfo:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.teamCell, for: indexPath) as! TeamCell
                
                return cell
            case .memberCard:
                if indexPath.row == self.viewModel.members.count {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.addMemberCell, for: indexPath) as! AddMemberCell
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.memberCell, for: indexPath) as! MemberCell
                    
                    guard let member = item.member else { return cell }
                    cell.configureCell(withMember: member)
                    
                    return cell
                }
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
        initialSnapshot.appendItems([.team], toSection: .teamInfo)
        
        sections = initialSnapshot.sectionIdentifiers
        teamCollectionView.sections = sections
        dataSource?.apply(initialSnapshot, animatingDifferences: true)
    }
    
    private func updateSnapshot(with members: [Member]) {
        guard let dataSource = self.dataSource else { return }
        
        var snapshot = dataSource.snapshot()
        
        let previousItems = snapshot.itemIdentifiers(inSection: .memberCard)
        snapshot.deleteItems(previousItems)
        
        let memberItems = members.map { MainItem.member($0) }
        snapshot.appendItems(memberItems, toSection: .memberCard)
        snapshot.appendItems([.member(Member(id: UUID(), name: "", imageURL: "", content: ""))])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
