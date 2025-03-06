//
//  MainViewController+DataSource.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/6/25.
//

import UIKit

extension MainViewController {
    // DataSource 생성, SupplementaryView 설정, 초기 스냅샷을 적용
    func configureDataSource() {
        dataSource = createDataSource()
        createSupplementaryViewProvider()
        applyInitialSnapshot()
    }
    
    // 컬렉션 뷰의 DataSource를 생성해 반환
    // 셀을 어떻게 구성할지 cellProvider를 구현
    private func createDataSource() -> UICollectionViewDiffableDataSource<MainSection, MainItem> {
        let dataSource = UICollectionViewDiffableDataSource<MainSection, MainItem>(
            collectionView: teamCollectionView.collectionView) { [weak self] collectionView, indexPath, item in
                self?.makeCell(collectionView: collectionView, indexPath: indexPath, item: item)
            }
        return dataSource
    }
    
    // indexPath와 item 정보에 따라 알맞은 셀(TeamCell, MemberCell, AddMemberCell)을 생성/반환
    private func makeCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: MainItem
    ) -> UICollectionViewCell? {
        let sections = self.sections[indexPath.section]
        
        switch sections {
        case .teamInfo:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReuseIdentifier.teamCell,
                for: indexPath
            ) as! TeamCell
            return cell
            
        case .memberCard:
            // 만약 마지막 멤버 셀이면 'AddMemberCell'을 반환
            if isAddMemberCell(indexPath: indexPath) {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ReuseIdentifier.addMemberCell,
                    for: indexPath
                ) as! AddMemberCell
                return cell
            } else {
                // 일반 멤버 셀
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ReuseIdentifier.memberCell,
                    for: indexPath
                ) as! MemberCell
                
                guard let member = item.member else { return cell }
                cell.configureCell(withMember: member)
                
                return cell
            }
        }
    }
    
    // 섹션별 보조뷰 설정
    private func createSupplementaryViewProvider() {
        dataSource?.supplementaryViewProvider = {
            [weak self] collectionView, kind, indexPath in
            guard let self else { return nil }
            
            // 보조뷰 종류별로 처리
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
                
                // 등록해 둔 헤더 뷰를 가져와 섹션 타이틀을 설정
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: SupplementaryViewKind.header,
                    withReuseIdentifier: ReuseIdentifier.mainHeaderView,
                    for: indexPath
                ) as! MainHeaderView
                headerView.configureHeader(withTitle: sectionTitle)
                
                return headerView
                
            default:
                return nil
            }
        }
    }
    
    // 초기 스냅샷을 적용해, teamInfo 섹션과 memberCard 섹션을 생성하고 .team 아이템 하나를 추가
    private func applyInitialSnapshot() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<MainSection, MainItem>()
        initialSnapshot.appendSections([.teamInfo, .memberCard])
        initialSnapshot.appendItems([.team], toSection: .teamInfo)
        
        sections = initialSnapshot.sectionIdentifiers // 섹션 정보를 로컬 프로퍼티에 저장 (header 등에서 사용)
        teamCollectionView.sections = sections // teamCollectionView가 사용할 섹션 정보 설정 (레이아웃 계산 등에 활용)
        dataSource?.apply(initialSnapshot, animatingDifferences: true) // 스냅샷을 적용해 UI 업데이트
    }
    
    // 뷰모델에서 전달된 members 배열에 따라 memberCard 섹션의 아이템들을 갱신
    func updateSnapshot(with members: [Member]) {
        guard let dataSource = self.dataSource else { return }
        
        var snapshot = dataSource.snapshot()
        
        // memberCard 섹션에 기존에 있던 아이템들 제거
        let previousItems = snapshot.itemIdentifiers(inSection: .memberCard)
        snapshot.deleteItems(previousItems)
        
        // 최신 멤버 배열을 MainItem.member 타입으로 변환한 뒤 섹션에 추가
        let memberItems = members.map { MainItem.member($0) }
        snapshot.appendItems(memberItems, toSection: .memberCard)
        
        // 맨 마지막에 '멤버 추가'용 아이템을 추가 (AddMemberCell로 표시됨)
        snapshot.appendItems([.member(Member(id: UUID(), name: "", imageURL: "", content: ""))])
        
        // 변경된 스냅샷을 적용해 화면에 반영
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
