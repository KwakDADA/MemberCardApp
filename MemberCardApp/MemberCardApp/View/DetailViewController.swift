//
//  DetailViewController.swift
//  MemberCardApp
//
//  Created by 권순욱 on 3/3/25.
//

import UIKit

final class DetailViewController: UIViewController {

    let member: Member
    
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
    
    // 하단 내용의 레이블
    private lazy var nameLabel = makeLabel(title: "이름")
    private lazy var contentLabel = makeLabel(title: "내용")
    
    // 하단 실제 내용
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
        // 버튼 스택 뷰
        let spacer = UIView()
        let buttonStackView = UIStackView(arrangedSubviews: [spacer, deleteButton, editButton])
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .trailing
        buttonStackView.spacing = 8
        
        // 내용1(이름) 스택 뷰
        let content1StackView = UIStackView(arrangedSubviews: [nameLabel, memberName])
        content1StackView.axis = .vertical
        content1StackView.spacing = 4
        
        // 내용2(실제 내용) 스택 뷰
        let content2StackView = UIStackView(arrangedSubviews: [contentLabel, contentLabelText])
        content2StackView.axis = .vertical
        content2StackView.spacing = 4
        
        // 내용 전체 스택 뷰(이름, 내용)
        let contentsStackViewSpacer = UIView()
        let contentsStackView = UIStackView(arrangedSubviews: [content1StackView, content2StackView, contentsStackViewSpacer])
        contentsStackView.axis = .vertical
        contentsStackView.spacing = 8
        
        // 화면 전체 스택 뷰
        let stackView = UIStackView(arrangedSubviews: [buttonStackView, imageView, contentsStackView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // 오토 레이아웃
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            contentsStackView.heightAnchor.constraint(equalToConstant: 300),
            
            contentsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            contentsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
            // imageView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            
//            content1StackView.widthAnchor.constraint(equalToConstant: 50),
//            content3StackView.widthAnchor.constraint(equalToConstant: 200),
            
            nameLabel.widthAnchor.constraint(equalToConstant: 40),
            contentLabel.widthAnchor.constraint(equalToConstant: 40),
            
            spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    }
    
    private func makeButton(title: String) -> UIButton {
        let button = UIButton(configuration: .tinted())
        button.setTitle(title, for: .normal)
        return button
    }
    
    private func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.backgroundColor = .orange
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    private func setupActionButtons() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func editButtonTapped() {
        // navigation?.push(AddEditViewController(member: member))
    }
    
    @objc private func deleteButtonTapped() {
        // MemberViewModel().removeMember(withId: member.id)
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
