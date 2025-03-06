//
//  DetailViewController.swift
//  MemberCardApp
//
//  Created by 권순욱 on 3/3/25.
//

import UIKit

final class DetailViewController: UIViewController {

    private var member: Member
    private let viewModel = MemberViewModel.shared
    
    // 상단 버튼 2개
    private lazy var deleteButton = makeButton(title: "삭제")
    private lazy var editButton = makeButton(title: "편집")
    
    // 중앙 이미지 뷰
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // 하단 멤버 이름 정보 뷰(제목, 내용)
    private lazy var nameLabel = makeLabel(title: "이름")
    private lazy var memberName: UILabel = {
        let label = UILabel()
        label.text = member.name
        return label
    }()
    
    // 하단 멤버 소개내용 정보 뷰(제목, 내용)
    private lazy var contentLabel = makeLabel(title: "내용")
    private lazy var contentText: UILabel = {
        let label = UILabel()
        label.text = member.content
        label.numberOfLines = 0
        return label
    }()
    
    init(member: Member) {
        self.member = member
        super.init(nibName: nil, bundle: nil)
        
        // 멤버 이미지 로드
        loadImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupActionButtons()
    }
    
    // AddEditViewController에서 편집을 마치고 돌아오면, 새 정보 로드하여 뷰에 반영
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchMembers()
        guard let index = viewModel.members.firstIndex(where: { $0.id == member.id }) else { fatalError() }
        member = viewModel.members[index]
        memberName.text = member.name
        contentText.text = member.content
        loadImage()
    }
    
    private func setupUI() {
        // 스크롤 뷰
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // 버튼 스택 뷰(내비게이션 바 버튼)
        let buttonStackView = UIStackView(arrangedSubviews: [deleteButton, editButton])
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .trailing
        buttonStackView.spacing = 8
        
        let stackBarButtonItem = UIBarButtonItem(customView: buttonStackView)
        navigationItem.rightBarButtonItem = stackBarButtonItem
        
        // 화면 전체 스택 뷰
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel, memberName, contentLabel, contentText])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        // 오토 레이아웃
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40),
            
            imageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    // MARK: - 액션 버튼
    private func setupActionButtons() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func editButtonTapped() {
        self.navigationController?.pushViewController(AddEditViewController(member: member),animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        viewModel.deleteMember(id: member.id)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 헬퍼 메서드
    private func makeButton(title: String) -> UIButton {
        let button = UIButton(configuration: .tinted())
        button.setTitle(title, for: .normal)
        return button
    }
    
    private func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = "  \(title)"
        label.backgroundColor = .orange
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
    
    private func loadImage() {
        ImageLoader.shared.loadImage(from: member.imageURL) {
            // 이미지 로딩 실패 시 시스템 이미지 로드
            guard let image = $0 else {
                self.imageView.image = UIImage(systemName: "photo")
                return
            }
            self.imageView.image = image
        }
    }
    
}
