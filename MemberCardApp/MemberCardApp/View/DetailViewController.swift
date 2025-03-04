//
//  DetailViewController.swift
//  MemberCardApp
//
//  Created by 권순욱 on 3/3/25.
//

import UIKit

final class DetailViewController: UIViewController {

    let member: Member
    private let viewModel = MemberViewModel.shared
    
    // 상단 버튼 2개
    private lazy var deleteButton = makeButton(title: "삭제")
    private lazy var editButton = makeButton(title: "편집")
    
    // 중앙 이미지 뷰
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // 하단 소제목
    private lazy var nameLabel = makeLabel(title: "이름")
    private lazy var contentLabel = makeLabel(title: "내용")
    
    // 하단 내용
    private lazy var memberName: UILabel = {
        let label = UILabel()
        label.text = member.name
        return label
    }()
    
    private lazy var contentLabelText: UILabel = {
        let label = UILabel()
        label.text = member.content
        label.numberOfLines = 0
        return label
    }()
    
    init(member: Member) {
        self.member = member
        super.init(nibName: nil, bundle: nil)
        
        // 이미지 로드
        ImageLoader.shared.loadImage(from: member.imageURL) {
            guard let image = $0 else {
                self.imageView.image = UIImage(systemName: "photo")
                return
            }
            self.imageView.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupUI()
        setupActionButtons()
    }
    
    private func setupUI() {
        // 스크롤 뷰
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // 버튼 스택 뷰 -> 내비게이션 바 버튼
        let spacer = UIView()
        let buttonStackView = UIStackView(arrangedSubviews: [spacer, deleteButton, editButton])
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .trailing
        buttonStackView.spacing = 8
        
        let stackBarButtonItem = UIBarButtonItem(customView: buttonStackView)
        navigationItem.rightBarButtonItem = stackBarButtonItem
        
        // 화면 전체 스택 뷰
        let stackViewSpacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel, memberName, contentLabel, contentLabelText, stackViewSpacer])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // view.addSubview(stackView)
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
            
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
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
    
    private func setupActionButtons() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func editButtonTapped() {
        print("editButton tapped.")
        navigation?.push(AddEditViewController(member: member))
    }
    
    @objc private func deleteButtonTapped() {
        print("deleteButton tapped.")
        viewModel.deleteMember(id: member.id)
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
