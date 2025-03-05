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
    private let memberViewModel = MemberViewModel()
    
    var member: Member
    
    private var selectedImageURL: String?
    
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
    
    private func setupUI() {
        let stackBarButtonItem = UIBarButtonItem(customView: addEditView.buttonStackView)
        navigationItem.rightBarButtonItem = stackBarButtonItem
        
        addEditView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        addEditView.profileImageView.isUserInteractionEnabled = true
        addEditView.profileImageView.addGestureRecognizer(tapGesture)
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
        print("저장 버튼 터치")
        guard let imageURL = self.selectedImageURL,
              let name = self.addEditView.nameTextField.text, !name.isEmpty,
              let content = self.addEditView.contentTextView.text, !content.isEmpty else {
//            alertView merge 이후 반영
//            addEditView.createAlert(message: "빈칸을 채워주세요")
            return
        }
        
//        addMember가 잘 작동하는지 테스트 필요
        memberViewModel.addMember(name: name, imageURL: imageURL, content: content)
    }
}
