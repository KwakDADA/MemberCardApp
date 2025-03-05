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
        addSubview(profileImageView)
        addSubview(nameTextField)
        addSubview(contentTextView)
        setupMemberStackView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setMemberStackViewConstraints() {
        memberStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memberStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
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
