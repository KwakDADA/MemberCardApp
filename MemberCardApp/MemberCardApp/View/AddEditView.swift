//
//  AddEditView.swift
//  MemberCardApp
//
//  Created by shinyoungkim on 3/3/25.
//

import UIKit

final class AddEditView: UIView {
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    let nameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "이름"
        textField.backgroundColor = UIColor(
            red: 241.0/255.0,
            green: 243.0/255.0,
            blue: 245.0/255.0,
            alpha: 1.0
        )
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(
            red: 241.0/255.0,
            green: 243.0/255.0,
            blue: 245.0/255.0,
            alpha: 1.0
        )
        textView.layer.cornerRadius = 8
        textView.layer.masksToBounds = true
        return textView
    }()
    
    let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 8
        return sv
    }()
    
    let memberStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 8
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupButtonStackView()
        addSubview(profileImageView)
        addSubview(nameTextField)
        addSubview(contentTextView)
        setupMemberStackView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtonStackView() {
        let spacerView = UIView()
        buttonStackView.addArrangedSubview(spacerView)
        buttonStackView.addArrangedSubview(addButton)
        
        self.addSubview(buttonStackView)
    }
    
    func setupMemberStackView() {
        memberStackView.addArrangedSubview(profileImageView)
        memberStackView.addArrangedSubview(nameTextField)
        memberStackView.addArrangedSubview(contentTextView)
        
        self.addSubview(memberStackView)
    }
    
    func setConstraints() {
        setProfileImageViewConstraints()
        setContentTextViewConstraints()
        setButtonStackViewConstraints()
        setMemberStackViewConstraints()
    }
    
    func setProfileImageViewConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func setContentTextViewConstraints() {
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentTextView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func setButtonStackViewConstraints() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    func setMemberStackViewConstraints() {
        memberStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memberStackView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20),
            memberStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            memberStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}

extension AddEditView {
    func createAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(confirmAction)
        
        return alert
    }
}
