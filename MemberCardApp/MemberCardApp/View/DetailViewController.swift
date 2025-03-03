//
//  DetailViewController.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class DetailViewController: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    let content: String
    let image: UIImage
    let isNew: Bool
    
    private let deleteButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("삭제", for: .normal)
        return button
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("편집", for: .normal)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle("저장", for: .normal)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "내용"
        return textfield
    }()
    
    init(content: String, image: UIImage, isNew: Bool = false, frame: CGRect) {
        self.content = content
        self.image = image
        self.isNew = isNew
        
        super.init(frame: frame)
        
        setupUI()
        setupActionButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 버튼 스택 뷰
        let spacer = UIView()
        
        let buttonStackView = if isNew {
            UIStackView(arrangedSubviews: [spacer, deleteButton, editButton])
        } else {
            UIStackView(arrangedSubviews: [spacer, saveButton])
        }
        // let buttonStackView = UIStackView(arrangedSubviews: [spacer, deleteButton, editButton])
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .trailing
        buttonStackView.spacing = 8
        
        // 화면 전체 스택 뷰
        let stackView = UIStackView(arrangedSubviews: [buttonStackView, imageView, textfield])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        // 오토 레이아웃
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: safeAreaLayoutGuide.bottomAnchor, multiplier: -20),
            
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            textfield.heightAnchor.constraint(equalToConstant: 300),
            
            spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    }
    
    private func setupActionButtons() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func editButtonTapped() {
        
    }
    
    @objc private func deleteButtonTapped() {
        
    }
}
