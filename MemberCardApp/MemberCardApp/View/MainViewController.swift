//
//  MainViewController.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = MemberViewModel.shared
    var dataSource: UICollectionViewDiffableDataSource<MainSection, MainItem>?
    var sections: [MainSection] = []
    
    // MARK: - View
    lazy var teamCollectionView: TeamCollectionView = .init()
    
    override func loadView() {
        view = teamCollectionView
    }
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDelegate()
        configureDataSource()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchMembers()
    }
    
    // MARK: - Methods
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupDelegate() {
        teamCollectionView.collectionView.delegate = self
    }
    
    // 뷰모델의 멤버 데이터가 갱신되면 컬렉션뷰 스냅샷 업데이트
    private func bindViewModel() {
        viewModel.onMembersUpdated = { [weak self] members in
            DispatchQueue.main.async {
                self?.updateSnapshot(with: members)
            }
        }
    }
    
    // 전달된 indexPath가 '멤버추가' 셀(멤버 목록의 마지막 위치)인지 판별
    func isAddMemberCell(indexPath: IndexPath) -> Bool {
        indexPath.row == viewModel.members.count
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 데이터소스에서 현재 셀에 해당하는 MainItem을 가져오고,
        // 그것이 .member(Member) 타입인지 확인
        guard let item = dataSource?.itemIdentifier(for: indexPath),
              let member = item.member else { return }
        
        if isAddMemberCell(indexPath: indexPath) {
            // 멤버 추가 화면으로 이동
            self.navigationController?.pushViewController(
                AddEditViewController(member: member),
                animated: true
            )
        } else {
            // 선택한 멤버 상세화면으로 이동
            self.navigationController?.pushViewController(
                DetailViewController(member: member),
                animated: true
            )
        }
    }
}
