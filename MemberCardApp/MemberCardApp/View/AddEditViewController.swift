//
//  AddEditViewController.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class AddEditViewController: UIViewController {
    private let addEditView = AddEditView()
    
    private let imagePickerViewModel = ImagePickerViewModel()
    
    var member: Member
    
    private var selectedImageURL: String?
    
    var editMode: Bool?
    
    init(member: Member){
        self.member = member
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = addEditView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupImagePicker()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupUI() {
        let addButton = UIBarButtonItem(customView: addEditView.addButton)
        navigationItem.rightBarButtonItem = addButton
        
        addEditView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        addEditView.profileImageView.isUserInteractionEnabled = true
        addEditView.profileImageView.addGestureRecognizer(tapGesture)
        
        if !self.member.name.isEmpty || !self.member.imageURL.isEmpty || !self.member.content.isEmpty {
            self.loadImage(from: URL(string: self.member.imageURL)!)
            self.addEditView.nameTextField.text = self.member.name
            self.addEditView.contentTextView.text = self.member.content
            self.selectedImageURL = self.member.imageURL
            editMode = true
        }
    }
    
    private func setupImagePicker() {
        imagePickerViewModel.onImageUpload = { [weak self] imageURL in
            guard let self = self, let imageURL = imageURL, let url = URL(string: imageURL) else { return }
            self.selectedImageURL = imageURL
            self.loadImage(from: url)
        }
    }
    
    @objc func imageViewTapped() {
        imagePickerViewModel.presentImagePicker(from: self)
    }
    
    private func loadImage(from url: URL) {
        ImageLoader.shared.loadImage(from: url.absoluteString) { [weak self] image in
            guard let self = self else { return }
            self.addEditView.profileImageView.image = image
        }
    }
    
    @objc func addButtonTapped() {
        guard let imageURL = self.selectedImageURL,
              let name = self.addEditView.nameTextField.text, !name.isEmpty,
              let content = self.addEditView.contentTextView.text, !content.isEmpty else {
            
            let alert = addEditView.createAlert(message: "빈칸을 채워주세요")
            present(alert, animated: true, completion: nil)
            return
        }
        
        if editMode ?? false {
            MemberViewModel.shared.updateMember(id: self.member.id, name: name, imageURL: imageURL, content: content)
        } else {
            MemberViewModel.shared.addMember(name: name, imageURL: imageURL, content: content)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
