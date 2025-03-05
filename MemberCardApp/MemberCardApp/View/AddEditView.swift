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
    
    let contentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "내용"
        return textField
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 8
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupStackView()
        addSubview(profileImageView)
        addSubview(contentTextField)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        let spacerView = UIView()
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(addButton)
        
        self.addSubview(stackView)        
    }
    
    func setConstraints() {
        setProfileImageViewConstraints()
        setContentTextFieldConstraints()
        setStackViewConstraints()
    }
    
    func setProfileImageViewConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            profileImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            profileImageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func setContentTextFieldConstraints() {
        contentTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            contentTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
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
